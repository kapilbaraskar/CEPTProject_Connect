<%@ Page Title="Research Details" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="Research.aspx.cs" Inherits="Admin_Profile_Research" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
  <!-- SheetJS Library for Excel Import/Export -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="research-tab" role="tabpanel">
                
                <!-- Main Header -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                            <i class="fas fa-microscope me-2" style="font-size: 1rem;"></i>
                            Research Projects
                        </h5>
                    </div>
                </div>

                <!-- Year Filter -->
                <div class="card mb-4" style="display:none;">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-calendar-alt me-2" style="font-size: 0.85rem;"></i>
                            Filter by Year
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <label class="form-label">Select Year</label>
                                <select id="yearFilter" name="yearFilter" class="form-select">
                                    <option value="" selected disabled>Select Year</option>
                                </select>
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="button" id="btnLoadData" class="btn btn-primary btn-sm">
                                    <i class="fas fa-search me-2"></i>
                                    Load Data
                                </button>
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="button" id="btnLoadCurrentYear" class="btn btn-success btn-sm">
                                    <i class="fas fa-calendar-check me-2"></i>
                                    Load Current Year
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- All Years Research Projects History -->
                <div class="card mb-4" id="allYearsSection">
                    <div class="card-header" style="background-color:#d1ecf1;border-color: #17a2b8;">
                        <div class="d-flex justify-content-between align-items-center flex-wrap">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: #0c5460;">
                                <i class="fas fa-database me-2" style="font-size: 0.85rem;"></i>
                                All Years Research Projects History
                                <span id="allYearsRecordsCount" class="badge bg-info ms-2" style="font-size: 0.75rem;">0</span>
                            </h5>
                            <div>
                                <button type="button" id="btnRefreshAllYears" class="btn btn-info btn-sm">
                                    <i class="fas fa-sync me-2"></i>
                                    Refresh
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div id="allYearsResearchList">
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-spinner fa-spin fa-2x mb-3"></i>
                                <p>Loading all years research projects history...</p>
                            </div>
                        </div>
                    </div>
                </div>
               

                <!-- Add New Research Form -->
                <div class="card mb-4" id="researchForm">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                            Add New Research Project
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <label class="form-label required">Title</label>
                                <input type="text" id="title" name="title" class="form-control" placeholder="Enter research project title" required maxlength="200">
                                <div class="text-end mt-1">
                                    <small class="text-muted">
                                        <span id="titleCharCount">0</span> characters (Max: 200 characters)
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Type</label>
                                <select id="type" name="type" class="form-select" required>
                                    <option value="" selected disabled>Select Research Type</option>
                                    <option value="Basic Research">Basic Research</option>
                                    <option value="Applied Research">Applied Research</option>
                                    <option value="Development Research">Development Research</option>
                                    <option value="Collaborative Research">Collaborative Research</option>
                                    <option value="Industry Sponsored">Industry Sponsored</option>
                                    <option value="Government Funded">Government Funded</option>
                                    <option value="International Project">International Project</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Status</label>
                                <select id="status" name="status" class="form-select" required>
                                    <option value="" selected disabled>Select Status</option>
                                    <option value="Proposed">Proposed</option>
                                    <option value="Under Review">Under Review</option>
                                    <option value="Approved">Approved</option>
                                    <option value="In Progress">In Progress</option>
                                    <option value="Completed">Completed</option>
                                    <option value="On Hold">On Hold</option>
                                    <option value="Cancelled">Cancelled</option>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label required">Description</label>
                                <textarea id="description" name="description" class="form-control" rows="3" placeholder="Enter research project description" required maxlength="1000"></textarea>
                                <div class="text-end mt-1">
                                    <small class="text-muted">
                                        <span id="descCharCount">0</span> characters (Max: 1000 characters)
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Funding Agency</label>
                                <input type="text" id="funding_agency" name="funding_agency" class="form-control" placeholder="Enter funding agency name" maxlength="150">
                                <div class="text-end mt-1">
                                    <small class="text-muted">
                                        <span id="fundingCharCount">0</span> characters (Max: 150 characters)
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Fund Available</label>
                                <input type="text" id="fund_available" name="fund_available" class="form-control" placeholder="Enter fund amount" maxlength="50">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Duration</label>
                                <input type="text" id="duration" name="duration" class="form-control" placeholder="Enter project duration" maxlength="100">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Start Date</label>
                                <input type="month" id="start_date" name="start_date" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">End Date</label>
                                <input type="month" id="end_date" name="end_date" class="form-control" required>
                            </div>
                            <div class="col-md-12" style="padding-top: 15px;">
                                <button type="button" id="btnAddResearch" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-2"></i>
                                    Add Research Project
                                </button>
                                <button type="button" id="btnUpdateResearch" class="btn btn-warning btn-sm" style="display: none;">
                                    <i class="fas fa-edit me-2"></i>
                                    Update Research Project
                                </button>
                                <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                    <i class="fas fa-times me-2"></i>
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>


                 <!-- Excel Import/Export Section -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color:#e3f2fd;border-color: #90caf9;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-file-excel me-2" style="font-size: 0.85rem; color: #1e7e34;"></i>
                            Excel Import/Export
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Step 1: Download Template -->
                            <div class="col-md-6 mb-3">
                                <div class="excel-section" style="background-color: #e8f5e9; padding: 15px; border-radius: 8px; border: 1px solid #c8e6c9;">
                                    <h6 style="color: #2e7d32; font-size: 13px; font-weight: 600; margin-bottom: 10px;">
                                        <i class="fas fa-download me-2"></i>Step 1: Download Excel Template
                                    </h6>
                                    <p style="font-size: 12px; color: #555; margin-bottom: 10px;">
                                        Download a pre-formatted Excel template with sample data and instructions.
                                    </p>
                                    <button type="button" id="btnDownloadExcel" class="btn btn-success btn-sm">
                                        <i class="fas fa-file-excel me-2"></i>
                                        Download Excel Template
                                    </button>
                                </div>
                            </div>

                            <!-- Step 2: Upload Template -->
                            <div class="col-md-6 mb-3">
                                <div class="excel-section" style="background-color: #fff3e0; padding: 15px; border-radius: 8px; border: 1px solid #ffe0b2;">
                                    <h6 style="color: #e65100; font-size: 13px; font-weight: 600; margin-bottom: 10px;">
                                        <i class="fas fa-upload me-2"></i>Step 2: Upload Filled Template
                                    </h6>
                                    <p style="font-size: 12px; color: #555; margin-bottom: 10px;">
                                        Upload your filled Excel file to import multiple research projects at once.
                                    </p>
                                    <div class="d-flex gap-2 align-items-center">
                                        <input type="file" id="excelFileUpload" accept=".xlsx,.xls" class="form-control form-control-sm" style="max-width: 250px;">
                                        <button type="button" id="btnUploadExcel" class="btn btn-primary btn-sm">
                                            <i class="fas fa-cloud-upload-alt me-2"></i>
                                            Upload & Import
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Excel Preview Section (Hidden by default) -->
                        <div id="excelPreviewSection" style="display: none; margin-top: 20px;">
                            <div class="alert alert-info" style="font-size: 12px;">
                                <i class="fas fa-info-circle me-2"></i>
                                <strong>Preview:</strong> Review the imported data below. Click "Confirm Import" to add all research projects or "Cancel" to discard.
                            </div>
                            <div class="table-responsive" style="max-height: 400px; overflow-y: auto; border: 1px solid #dee2e6; border-radius: 6px;">
                                <table class="table table-sm table-bordered table-hover mb-0" id="excelPreviewTable">
                                    <thead class="table-light" style="position: sticky; top: 0; z-index: 10;">
                                        <tr style="font-size: 11px;">
                                            <th>S.No</th>
                                            <th>Type</th>
                                            <th>Title</th>
                                            <th>Status</th>
                                            <th>Funding Agency</th>
                                            <th>Fund Available</th>
                                            <th>Duration</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                        </tr>
                                    </thead>
                                    <tbody id="excelPreviewBody" style="font-size: 11px;">
                                    </tbody>
                                </table>
                            </div>
                            <div class="mt-3 d-flex gap-2">
                                <button type="button" id="btnConfirmImport" class="btn btn-success btn-sm">
                                    <i class="fas fa-check me-2"></i>
                                    Confirm Import (<span id="excelRecordCount">0</span> projects)
                                </button>
                                <button type="button" id="btnCancelImport" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-times me-2"></i>
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Research Records List - Current Year -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color:#fff3cd;border-color: #ffc107;">
                        <div class="d-flex justify-content-between align-items-center flex-wrap">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: #856404;">
                                <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                                Research Projects Records List - Current Year
                                <span id="recordsCount" class="badge bg-warning text-dark ms-2" style="font-size: 0.75rem;">0</span>
                            </h5>
                            <div>
                                <span id="currentYearDisplay" class="badge bg-primary" style="font-size: 0.85rem;">
                                    <i class="fas fa-calendar me-1"></i>
                                    <span id="currentYearCode"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div id="researchRecordsList">
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-microscope fa-2x mb-3"></i>
                                <p>No research projects added yet. Add your first research project above.</p>
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

        .badge {
            font-size: 10px;
            padding: 4px 8px;
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
        var researchRecords = [];
        var editingIndex = -1;
        var excelDataPreview = [];
        var researchTypesMapping = {}; // Store TypeName -> TypeCode mapping
        
        // All Years section variables
        var allYearsRecords = [];

        $(document).ready(function () {
            // Excel feature event handlers
            $('#btnDownloadExcel').click(function () {
                downloadExcelTemplate();
            });

            $('#btnUploadExcel').click(function () {
                var fileInput = document.getElementById('excelFileUpload');
                if (fileInput.files.length === 0) {
                    showErrorMessage('Please select an Excel file first!');
                    return;
                }
                uploadAndParseExcel(fileInput.files[0]);
            });

            $('#btnConfirmImport').click(function () {
                confirmExcelImport();
            });

            $('#btnCancelImport').click(function () {
                cancelExcelImport();
            });

            // Add research button click handler
            $('#btnAddResearch').click(function () {
                addResearchRecord();
            });

            // Update research button click handler
            $('#btnUpdateResearch').click(function () {
                updateResearchRecord();
            });

            // Cancel edit button click handler
            $('#btnCancelEdit').click(function () {
                cancelEdit();
            });

            // Save all button click handler
            $('#btnSaveAll').click(function () {
                saveAllResearchDetails();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Next button click handler
            $('#btnNext').click(function () {
                navigateToNextMenu();
            });

            // Character count for title
            $('#title').on('input', function () {
                updateTitleCharCount();
            });

            // Character count for description
            $('#description').on('input', function () {
                updateDescCharCount();
            });

            // Character count for funding agency
            $('#funding_agency').on('input', function () {
                updateFundingCharCount();
            });


            // Year filter functionality
            $('#btnLoadData').click(function () {
                var selectedYear = $('#yearFilter').val();
                if (selectedYear) {
                    loadResearchByYear(selectedYear);
                } else {
                    showErrorMessage('Please select a year first');
                }
            });

            $('#btnLoadCurrentYear').click(function () {
                var currentYear = new Date().getFullYear();
                var currentYearCode = currentYear + '-' + (currentYear + 1);
                $('#yearFilter').val(currentYearCode);
                loadResearchByYear(currentYearCode);
            });

            // Refresh All Years button click handler
            $('#btnRefreshAllYears').click(function () {
                loadAllYearsResearch();
            });

            // Load year options and current year data
            loadYearOptions();
            loadCurrentYearData();

            // Load existing research records (loads types, then current year data)
            loadPublicationsType();
            
            // Auto-load all years data on page load
            setTimeout(function() {
                loadAllYearsResearch();
            }, 1500); // Delay to ensure research types are loaded first
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'title', 'type', 'status', 'description', 'start_date', 'end_date'
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

            // Validate date range
            var startDate = $('#start_date').val();
            var endDate = $('#end_date').val();
            
            if (startDate && endDate && startDate > endDate) {
                showErrorMessage('End date must be after start date');
                isValid = false;
            }

            return isValid;
        }

        function addResearchRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var researchData = {
                title: $('#title').val(),
                typecode: $('#type').val(),
                type_name: $('#type option:selected').text(),
                status: $('#status').val(),
                description: $('#description').val(),
                funding_agency: $('#funding_agency').val(),
                funds_available: $('#fund_available').val(),
                duration: $('#duration').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                id: Date.now()
            };

            researchRecords.push(researchData);
            displayResearchRecords();
            clearForm();
            showTopRightMessage('Research project added successfully!');
        }

        function updateResearchRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var researchData = {
                title: $('#title').val(),
                typecode: $('#type').val(),
                type_name: $('#type option:selected').text(),
                status: $('#status').val(),
                description: $('#description').val(),
                funding_agency: $('#funding_agency').val(),
                funds_available: $('#fund_available').val(),
                duration: $('#duration').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                id: researchRecords[editingIndex].id
            };

            researchRecords[editingIndex] = researchData;
            displayResearchRecords();
            clearForm();
            cancelEdit();
            showTopRightMessage('Research project updated successfully!');
            
            // Call btnSaveAll click event after updating the record
            $('#btnSaveAll').click();
        }

        function editResearchRecord(index) {
            var record = researchRecords[index];
            
            // Fill form data
            $('#title').val(record.title);
            $('#type').val(record.typecode || record.type); // Handle both typecode and type for backward compatibility
            $('#status').val(record.status);
            $('#description').val(record.description);
            $('#funding_agency').val(record.funding_agency);
            $('#fund_available').val(record.funds_available || record.fund_available);
            $('#duration').val(record.duration);
            $('#start_date').val(record.start_date);
            $('#end_date').val(record.end_date);
            
            // Update character counts
            updateTitleCharCount();
            updateDescCharCount();
            updateFundingCharCount();
            
            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddResearch').hide();
            $('#btnUpdateResearch').show();
            $('#btnCancelEdit').show();
            
            // Highlight the form section
            var formCard = $('#title').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');
            
            // Remove highlight after 3 seconds
            setTimeout(function () {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', '');
            }, 3000);

            // Scroll to the edit section
            try {
                var titleField = document.getElementById('title');
                if (titleField) {
                    titleField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } catch (e) {
                try {
                    $('html, body').animate({
                        scrollTop: $('#title').offset().top - 100
                    }, 1000);
                } catch (e2) {
                    window.scrollTo(0, 0);
                }
            }
            
            showTopRightMessage('Research project loaded for editing!');
        }

        function deleteResearchRecord(index) {
            if (confirm('Are you sure you want to delete this research project?')) {
                researchRecords.splice(index, 1);
                displayResearchRecords();
                showTopRightMessage('Research project deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddResearch').show();
            $('#btnUpdateResearch').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#title').val('');
            $('#type').val('');
            $('#status').val('');
            $('#description').val('');
            $('#funding_agency').val('');
            $('#fund_available').val('');
            $('#duration').val('');
            $('#start_date').val('');
            $('#end_date').val('');
            
            // Reset character counts
            updateTitleCharCount();
            updateDescCharCount();
            updateFundingCharCount();
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function updateTitleCharCount() {
            var text = $('#title').val();
            var charCount = text.length;
            
            $('#titleCharCount').text(charCount);
            
            // Change color based on character limit
            var charCountElement = $('#titleCharCount');
            if (charCount > 180) {
                charCountElement.css('color', '#dc3545'); // Red for near limit
            } else if (charCount > 160) {
                charCountElement.css('color', '#ffc107'); // Yellow for warning
            } else {
                charCountElement.css('color', '#6c757d'); // Default muted color
            }
        }

        function updateDescCharCount() {
            var text = $('#description').val();
            var charCount = text.length;
            
            $('#descCharCount').text(charCount);
            
            // Change color based on character limit
            var charCountElement = $('#descCharCount');
            if (charCount > 900) {
                charCountElement.css('color', '#dc3545'); // Red for near limit
            } else if (charCount > 800) {
                charCountElement.css('color', '#ffc107'); // Yellow for warning
            } else {
                charCountElement.css('color', '#6c757d'); // Default muted color
            }
        }

        function updateFundingCharCount() {
            var text = $('#funding_agency').val();
            var charCount = text.length;
            
            $('#fundingCharCount').text(charCount);
            
            // Change color based on character limit
            var charCountElement = $('#fundingCharCount');
            if (charCount > 135) {
                charCountElement.css('color', '#dc3545'); // Red for near limit
            } else if (charCount > 120) {
                charCountElement.css('color', '#ffc107'); // Yellow for warning
            } else {
                charCountElement.css('color', '#6c757d'); // Default muted color
            }
        }


        function formatDateForDisplay(dateString) {
            if (dateString) {
                var parts = dateString.split('-');
                if (parts.length === 2) {
                    var month = parts[1];
                    var year = parts[0];
                    var monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    var monthName = monthNames[parseInt(month) - 1];
                    return monthName + '-' + year;
                }
            }
            return '';
        }

        // ========================================
        // DISPLAY CURRENT YEAR RESEARCH PROJECTS
        // ========================================
        function displayResearchRecords() {
            displayCurrentYearResearch();
        }

        function displayCurrentYearResearch() {
            var container = $('#researchRecordsList');
            
            // Update current year display
            var currentYear = new Date().getFullYear();
            var currentYearCode = currentYear + '-' + (currentYear + 1);
            $('#currentYearCode').text(currentYearCode);
            $('#recordsCount').text(researchRecords.length);
            
            if (researchRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-microscope fa-2x mb-3"></i>
                        <p>No research projects added yet for current year <strong>${currentYearCode}</strong>. Add your first research project above.</p>
                    </div>
                `);
                return;
            }

            var html = `
                <div class="alert alert-warning alert-dismissible fade show mb-3" role="alert" style="font-size: 12px;">
                    <i class="fas fa-info-circle me-2"></i>
                    <strong>Current Year Data:</strong> Showing ${researchRecords.length} research project(s) for academic year <strong>${currentYearCode}</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-warning">
                            <tr>
                                <th style="font-size: 12px; font-weight: 600;">S.No</th>
                                <th style="font-size: 12px; font-weight: 600;">Type</th>
                                <th style="font-size: 12px; font-weight: 600;">Title</th>
                                <th style="font-size: 12px; font-weight: 600;">Status</th>
                                <th style="font-size: 12px; font-weight: 600;">Funding Agency</th>
                                <th style="font-size: 12px; font-weight: 600;">Fund Available</th>
                                <th style="font-size: 12px; font-weight: 600;">Duration</th>
                                <th style="font-size: 12px; font-weight: 600;">Project Period</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            researchRecords.forEach(function (record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getTypeBadgeClass(record.typecode)}">${record.type_name || record.typecode || 'N/A'}</span>
                        </td>
                        <td style="font-size: 12px;" title="${record.title || '-'}">${record.title ? (record.title.length > 20 ? record.title.substring(0, 20) + '...' : record.title) : '-'}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getStatusBadgeClass(record.status)}">${record.status || 'N/A'}</span>
                        </td>
                        <td style="font-size: 12px;" title="${record.funding_agency || '-'}">${record.funding_agency ? (record.funding_agency.length > 15 ? record.funding_agency.substring(0, 15) + '...' : record.funding_agency) : '-'}</td>
                        <td style="font-size: 12px;">${record.funds_available || '-'}</td>
                        <td style="font-size: 12px;">${record.duration || '-'}</td>
                        <td style="font-size: 12px;">${record.start_date || 'N/A'} to ${record.end_date || 'N/A'}</td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editResearchRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteResearchRecord(${index})" title="Delete Record">
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
            console.log('✓ Displayed ' + researchRecords.length + ' current year research projects in table');
        }

        function getTypeBadgeClass(type) {
            switch (type) {
                case 'Basic Research': return 'bg-primary';
                case 'Applied Research': return 'bg-info';
                case 'Development Research': return 'bg-warning';
                case 'Collaborative Research': return 'bg-success';
                case 'Industry Sponsored': return 'bg-danger';
                case 'Government Funded': return 'bg-secondary';
                case 'International Project': return 'bg-dark';
                default: return 'bg-secondary';
            }
        }

        function getStatusBadgeClass(status) {
            switch (status) {
                case 'Proposed': return 'bg-secondary';
                case 'Under Review': return 'bg-warning';
                case 'Approved': return 'bg-info';
                case 'In Progress': return 'bg-primary';
                case 'Completed': return 'bg-success';
                case 'On Hold': return 'bg-dark';
                case 'Cancelled': return 'bg-danger';
                default: return 'bg-secondary';
            }
        }

        function saveAllResearchDetails() {
            if (researchRecords.length === 0) {
                showErrorMessage('No research projects to save');
                return;
            }

            // Use current year for saving
            var currentYear = new Date().getFullYear();
            var currentYearCode = currentYear + '-' + (currentYear + 1);

            $('#btnSaveAll').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

            $.ajax({
                url: '../../WebService.asmx/SaveResearchDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ formDataJson: JSON.stringify(researchRecords), yearcode: currentYearCode }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'Research projects saved successfully for current year: ' + currentYearCode);
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save research projects');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save research projects');
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Error saving research projects: ' + error);
                    console.error('AJAX Error:', xhr.responseText);
                },
                complete: function () {
                    $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
                }
            });
        }

        function loadYearOptions() {
            $.ajax({
                url: '../../WebService.asmx/GetYearData',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            // Clear existing options except the first one
                            $('#yearFilter').find('option:not(:first)').remove();

                            // Add new options from the web service
                            $.each(result, function (index, item) {
                                var option = $('<option></option>')
                                    .attr('value', item.YearCode || item.yearCode || item.year_code)
                                    .text(item.YearName || item.yearName || item.year_name || item.YearCode || item.yearCode);
                                $('#yearFilter').append(option);
                            });
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading year options:', error);
                    // Add default years if web service fails
                    addDefaultYearOptions();
                }
            });
        }

        function addDefaultYearOptions() {
            var currentYear = new Date().getFullYear();
            for (var i = currentYear - 5; i <= currentYear + 2; i++) {
                var yearCode = i + '-' + (i + 1);
                var yearName = i + '-' + (i + 1);
                var option = $('<option></option>')
                    .attr('value', yearCode)
                    .text(yearName);
                $('#yearFilter').append(option);
            }
        }

        function loadResearchByYear(year) {
            $.ajax({
                url: '../../WebService.asmx/GetResearchDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ yearcode: year }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        
                        if (result && result.length > 0) {
                            // Process each record to add type_name if not provided
                            result.forEach(function(record) {
                                if (!record.type_name && record.typecode) {
                                    $('#type option').each(function() {
                                        if ($(this).val() === record.typecode) {
                                            record.type_name = $(this).text();
                                            return false; // Break the loop
                                        }
                                    });
                                }
                            });
                            
                            researchRecords = result;
                        } else {
                            researchRecords = [];
                        }
                        
                        displayResearchRecords();
                        showTopRightMessage('Research data loaded for year: ' + year);
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading research by year:', error);
                    showErrorMessage('Failed to load research data for the selected year');
                }
            });
        }

        function loadCurrentYearData() {
            // This is called on page load - removed to avoid double loading
            // loadCurrentYearResearchData() is already called from loadPublicationsType()
        }

        function navigateToPreviousMenu() {
            // Navigate to previous page (Conferences)
            window.location.href = 'Conferences.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page (if any)
            showTopRightMessage('Research projects completed!');
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
        function loadPublicationsType() {
            $.ajax({
                url: '../../WebService.asmx/GetPublicationType',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: "{publicationtype : 'ResearchProject'}",
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            // Clear existing options except the first one
                            $('#type').find('option:not(:first)').remove();

                            // Add new options from the web service
                            $.each(result, function (index, item) {
                                var typeCode = item.TypeCode || item.TypeCode || item.TypeCode;
                                var typeName = item.TypeName || item.TypeName || item.TypeName;
                                
                                var option = $('<option></option>')
                                    .attr('value', typeCode)
                                    .text(typeName);
                                $('#type').append(option);
                                
                                // Store mapping for Excel import: TypeName -> TypeCode
                                researchTypesMapping[typeName] = typeCode;
                            });
                        }

                        // Load current year research data after types are loaded
                        loadCurrentYearResearchData();
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading publication types:', error);
                    // Still try to load data even if types fail
                    loadCurrentYearResearchData();
                }
            });
        }

        function loadCurrentYearResearchData() {
            // Get current year
            var currentYear = new Date().getFullYear();
            var currentYearCode = currentYear + '-' + (currentYear + 1);
            
            console.log('Loading current year research projects for: ' + currentYearCode);
            
            $.ajax({
                url: '../../WebService.asmx/GetResearchDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ yearcode: currentYearCode }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        
                        if (result && result.length > 0) {
                            // Process each record to add type_name if not provided
                            result.forEach(function(record) {
                                // Ensure typecode field exists
                                if (!record.typecode && record.type) {
                                    record.typecode = record.type;
                                }
                                
                                if (!record.type_name && record.typecode) {
                                    $('#type option').each(function() {
                                        if ($(this).val() === record.typecode) {
                                            record.type_name = $(this).text();
                                            return false; // Break the loop
                                        }
                                    });
                                }
                            });
                            
                            researchRecords = result;
                            displayResearchRecords();
                            console.log('✓ Loaded ' + result.length + ' current year research project(s)');
                        } else {
                            researchRecords = [];
                            displayResearchRecords();
                            console.log('No research projects found for current year: ' + currentYearCode);
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading current year research:', error);
                }
            });
        }

        // ========================================
        // EXCEL IMPORT/EXPORT FUNCTIONS
        // ========================================

        function downloadExcelTemplate() {
            try {
                var wb = XLSX.utils.book_new();

                var headers = [
                    'Type',
                    'Title',
                    'Status',
                    'Description',
                    'Funding Agency',
                    'Fund Available',
                    'Duration',
                    'Start Date (YYYY-MM)',
                    'End Date (YYYY-MM)'
                ];

                // Get available research types from dropdown
                var availableTypes = [];
                $('#type option').each(function() {
                    var value = $(this).val();
                    if (value) {
                        availableTypes.push($(this).text());
                    }
                });

                var firstType = availableTypes.length > 0 ? availableTypes[0] : 'Basic Research';
                var secondType = availableTypes.length > 1 ? availableTypes[1] : 'Applied Research';

                var sampleData1 = [
                    firstType,
                    'AI-Based Educational Platform Development',
                    'In Progress',
                    'Development of an intelligent tutoring system using machine learning algorithms',
                    'University Research Grant',
                    '500000',
                    '2 years',
                    '2024-01',
                    '2025-12'
                ];

                var sampleData2 = [
                    secondType,
                    'Smart City Infrastructure Research',
                    'Approved',
                    'Research on IoT-based infrastructure monitoring and optimization',
                    'Government Ministry',
                    '1000000',
                    '3 years',
                    '2024-03',
                    '2027-03'
                ];

                var typesString = availableTypes.length > 0 ? availableTypes.join(', ') : 'Basic Research, Applied Research, Development Research, Collaborative Research';

                var instructions = [
                    'INSTRUCTIONS:',
                    '1. Fill your research project data starting from Row 4',
                    '2. Delete these sample rows before uploading',
                    '3. Required fields: Type, Title, Status, Description, Start Date, End Date',
                    '4. Available Research Types: ' + typesString,
                    '5. Status: Proposed, Under Review, Approved, In Progress, Completed, On Hold, Cancelled',
                    '6. Date format: YYYY-MM (e.g., 2024-01 for January 2024)',
                    '7. End Date must be same as or after Start Date',
                    '8. Description max 1000 characters',
                    '9. Title max 200 characters',
                    '10. Save file and upload using "Upload & Import" button',
                    ''
                ];

                var wsData = [
                    headers,
                    sampleData1,
                    sampleData2,
                    [''],
                    instructions
                ];

                var ws = XLSX.utils.aoa_to_sheet(wsData);

                ws['!cols'] = [
                    { wch: 25 }, // Type
                    { wch: 40 }, // Title
                    { wch: 15 }, // Status
                    { wch: 50 }, // Description
                    { wch: 25 }, // Funding Agency
                    { wch: 15 }, // Fund Available
                    { wch: 15 }, // Duration
                    { wch: 18 }, // Start Date
                    { wch: 18 }  // End Date
                ];

                XLSX.utils.book_append_sheet(wb, ws, 'Research Projects');

                var today = new Date();
                var dateStr = today.getFullYear() + 
                             String(today.getMonth() + 1).padStart(2, '0') + 
                             String(today.getDate()).padStart(2, '0');
                var fileName = 'Research_Projects_Template_' + dateStr + '.xlsx';

                XLSX.writeFile(wb, fileName);

                showTopRightMessage('Excel template downloaded successfully!');
            } catch (error) {
                console.error('Error downloading Excel template:', error);
                showErrorMessage('Error generating Excel template: ' + error.message);
            }
        }

        function uploadAndParseExcel(file) {
            try {
                var reader = new FileReader();

                reader.onload = function (e) {
                    try {
                        var data = new Uint8Array(e.target.result);
                        var workbook = XLSX.read(data, { type: 'array' });

                        var firstSheetName = workbook.SheetNames[0];
                        var worksheet = workbook.Sheets[firstSheetName];

                        var jsonData = XLSX.utils.sheet_to_json(worksheet, { 
                            header: 1,
                            defval: '',
                            blankrows: false
                        });

                        if (jsonData.length === 0) {
                            showErrorMessage('Excel file is empty or has no data rows!');
                            return;
                        }

                        parseExcelData(jsonData);

                    } catch (parseError) {
                        console.error('Error parsing Excel file:', parseError);
                        showErrorMessage('Error parsing Excel file: ' + parseError.message);
                    }
                };

                reader.onerror = function (error) {
                    console.error('Error reading file:', error);
                    showErrorMessage('Error reading Excel file!');
                };

                reader.readAsArrayBuffer(file);

            } catch (error) {
                console.error('Error uploading Excel:', error);
                showErrorMessage('Error uploading Excel file: ' + error.message);
            }
        }

        function parseExcelData(jsonData) {
            excelDataPreview = [];
            var headers = jsonData[0];

            console.log('Available Research Types Mapping:', researchTypesMapping);

            for (var i = 1; i < jsonData.length; i++) {
                var row = jsonData[i];

                if (!row || row.length === 0) continue;
                if (row[0] && (row[0].toString().includes('INSTRUCTIONS') || 
                              row[0].toString().includes('Fill your research'))) {
                    continue;
                }

                var researchType = row[0] ? row[0].toString().trim() : '';
                var title = row[1] ? row[1].toString().trim() : '';
                var status = row[2] ? row[2].toString().trim() : '';
                var description = row[3] ? row[3].toString().trim() : '';
                var fundingAgency = row[4] ? row[4].toString().trim() : '';
                var fundAvailable = row[5] ? row[5].toString().trim() : '';
                var duration = row[6] ? row[6].toString().trim() : '';
                var startDate = row[7] ? row[7].toString().trim() : '';
                var endDate = row[8] ? row[8].toString().trim() : '';

                if (!researchType && !title && !description) {
                    continue;
                }

                if (!researchType || !title || !status || !description || !startDate || !endDate) {
                    console.warn('Skipping row ' + (i + 1) + ': Missing required fields');
                    continue;
                }

                // Map research type name to database TypeCode
                var researchTypeCode = researchTypesMapping[researchType];

                // Case-insensitive fallback
                if (!researchTypeCode) {
                    for (var typeName in researchTypesMapping) {
                        if (typeName.toLowerCase() === researchType.toLowerCase()) {
                            researchTypeCode = researchTypesMapping[typeName];
                            researchType = typeName;
                            break;
                        }
                    }
                }

                if (!researchTypeCode) {
                    console.warn('Skipping row ' + (i + 1) + ': Invalid Research Type "' + researchType + '"');
                    continue;
                }

                var researchData = {
                    typecode: researchTypeCode,
                    type_name: researchType,
                    title: title,
                    status: status || 'Proposed',
                    description: description,
                    funding_agency: fundingAgency,
                    funds_available: fundAvailable,
                    duration: duration,
                    start_date: startDate,
                    end_date: endDate,
                    id: Date.now() + i
                };

                excelDataPreview.push(researchData);
            }

            if (excelDataPreview.length === 0) {
                showErrorMessage('No valid data found in Excel file! Please check required fields.');
                return;
            }

            displayExcelPreview();
            showTopRightMessage('Found ' + excelDataPreview.length + ' research project(s) in Excel file!');
        }

        function displayExcelPreview() {
            var tbody = $('#excelPreviewBody');
            tbody.empty();

            excelDataPreview.forEach(function (record, index) {
                var row = `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${record.type_name || record.typecode}</td>
                        <td title="${record.title}">${record.title.length > 25 ? record.title.substring(0, 25) + '...' : record.title}</td>
                        <td>${record.status}</td>
                        <td title="${record.funding_agency}">${record.funding_agency ? (record.funding_agency.length > 20 ? record.funding_agency.substring(0, 20) + '...' : record.funding_agency) : '-'}</td>
                        <td>${record.funds_available || '-'}</td>
                        <td>${record.duration || '-'}</td>
                        <td>${record.start_date}</td>
                        <td>${record.end_date}</td>
                    </tr>
                `;
                tbody.append(row);
            });

            $('#excelRecordCount').text(excelDataPreview.length);
            $('#excelPreviewSection').slideDown();

            setTimeout(function () {
                $('html, body').animate({
                    scrollTop: $('#excelPreviewSection').offset().top - 20
                }, 500);
            }, 300);
        }

        function confirmExcelImport() {
            if (excelDataPreview.length === 0) {
                showErrorMessage('No data to import!');
                return;
            }

            excelDataPreview.forEach(function (record) {
                researchRecords.push(record);
            });

            displayResearchRecords();

            showTopRightMessage('Importing ' + excelDataPreview.length + ' research project(s)...');

            setTimeout(function () {
                saveAllResearchDetails();
            }, 500);

            cancelExcelImport();

            showTopRightMessage('Successfully imported ' + excelDataPreview.length + ' research project(s)!');
        }

        function cancelExcelImport() {
            excelDataPreview = [];
            $('#excelPreviewBody').empty();
            $('#excelPreviewSection').slideUp();
            $('#excelFileUpload').val('');
        }

        // ========================================
        // ALL YEARS RESEARCH PROJECTS FUNCTIONS
        // ========================================

        function loadAllYearsResearch() {
            // Show loading state
            $('#btnRefreshAllYears').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Loading...');

            // Load all research projects from database (pass empty string for yearcode to get all years)
            $.ajax({
                url: '../../WebService.asmx/GetResearchDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ yearcode: '' }), // Empty string to get ALL years
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);

                        if (result.length > 0) {
                            // Process each record to add type_name if not provided
                            result.forEach(function (record) {
                                // Ensure typecode field exists
                                if (!record.typecode && record.type) {
                                    record.typecode = record.type;
                                }
                                
                                if (!record.type_name && record.typecode) {
                                    $('#type option').each(function () {
                                        if ($(this).val() === record.typecode) {
                                            record.type_name = $(this).text();
                                            return false;
                                        }
                                    });
                                }
                            });

                            allYearsRecords = result;
                            displayAllYearsResearch();
                            console.log('✓ Loaded ' + result.length + ' research project(s) from all years');
                        } else {
                            allYearsRecords = [];
                            displayAllYearsResearch();
                            console.log('No research projects found in database');
                        }
                    } else {
                        showErrorMessage('Failed to load all years research projects');
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Error loading research projects: ' + error);
                    console.error('AJAX Error:', xhr.responseText);
                },
                complete: function () {
                    $('#btnRefreshAllYears').prop('disabled', false).html('<i class="fas fa-sync me-2"></i>Refresh');
                }
            });
        }

        // ========================================
        // DISPLAY ALL YEARS RESEARCH PROJECTS (HISTORICAL DATA)
        // ========================================
        function displayAllYearsResearch() {
            var container = $('#allYearsResearchList');
            var totalRecords = allYearsRecords.length;

            // Update records count badge
            $('#allYearsRecordsCount').text(totalRecords);

            if (totalRecords === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-database fa-2x mb-3"></i>
                        <p>No research projects found in database from any year.</p>
                    </div>
                `);
                return;
            }

            // Group records by year for summary
            var yearGroups = {};
            allYearsRecords.forEach(function(record) {
                var year = 'Unknown';
                if (record.start_date) {
                    year = record.start_date.split('-')[0];
                } else if (record.end_date) {
                    year = record.end_date.split('-')[0];
                }
                yearGroups[year] = (yearGroups[year] || 0) + 1;
            });

            // Create year summary text
            var yearSummary = Object.keys(yearGroups).sort().reverse().map(function(year) {
                return year + ' (' + yearGroups[year] + ')';
            }).join(', ');

            var html = `
                <div class="alert alert-info alert-dismissible fade show mb-3" role="alert" style="font-size: 12px;">
                    <i class="fas fa-database me-2"></i>
                    <strong>All Years Historical Data:</strong> Total ${totalRecords} research project(s)
                    <br><small class="mt-1 d-block"><strong>Year Distribution:</strong> ${yearSummary}</small>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover table-bordered">
                        <thead class="table-info">
                            <tr>
                                <th style="font-size: 12px; font-weight: 600;">S.No</th>
                                <th style="font-size: 12px; font-weight: 600;">Year</th>
                                <th style="font-size: 12px; font-weight: 600;">Type</th>
                                <th style="font-size: 12px; font-weight: 600;">Title</th>
                                <th style="font-size: 12px; font-weight: 600;">Status</th>
                                <th style="font-size: 12px; font-weight: 600;">Funding Agency</th>
                                <th style="font-size: 12px; font-weight: 600;">Fund Available</th>
                                <th style="font-size: 12px; font-weight: 600;">Duration</th>
                                <th style="font-size: 12px; font-weight: 600;">Project Period</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            allYearsRecords.forEach(function (record, index) {
                // Extract year from start_date
                var year = 'N/A';
                if (record.start_date) {
                    year = record.start_date.split('-')[0];
                } else if (record.end_date) {
                    year = record.end_date.split('-')[0];
                }

                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">
                            <span class="badge bg-secondary">${year}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getTypeBadgeClass(record.typecode)}">${record.type_name || record.typecode || 'N/A'}</span>
                        </td>
                        <td style="font-size: 12px;" title="${record.title || '-'}">
                            ${record.title ? (record.title.length > 25 ? record.title.substring(0, 25) + '...' : record.title) : '-'}
                        </td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getStatusBadgeClass(record.status)}">${record.status || 'N/A'}</span>
                        </td>
                        <td style="font-size: 12px;" title="${record.funding_agency || '-'}">
                            ${record.funding_agency ? (record.funding_agency.length > 20 ? record.funding_agency.substring(0, 20) + '...' : record.funding_agency) : '-'}
                        </td>
                        <td style="font-size: 12px;">${record.funds_available || '-'}</td>
                        <td style="font-size: 12px;">${record.duration || '-'}</td>
                        <td style="font-size: 12px;">${record.start_date || ''} to ${record.end_date || ''}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            container.html(html);
            console.log('✓ Displayed ' + totalRecords + ' research projects from all years in historical table');
        }
    </script>
</asp:Content>

