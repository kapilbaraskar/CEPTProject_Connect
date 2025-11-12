<%@ Page Title="Other Research Activity" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="OtherResearchActivities.aspx.cs" Inherits="Admin_Profile_OtherResearchActivities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Other Research Activities
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
  <!-- SheetJS Library for Excel Import/Export -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="other-research-tab" role="tabpanel">
                
                <!-- Main Header -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                            <i class="fas fa-microscope me-2" style="font-size: 1rem;"></i>
                            Other Research Activities
                        </h5>
                    </div>
                </div>

               

                <!-- Add New Research Activity Form -->
                <div class="card mb-4" id="researchActivityForm">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                            Add New Research Activity
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label required">Title</label>
                                <input type="text" id="title" name="title" class="form-control" placeholder="Enter research activity title" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Type</label>
                                <select id="type_code" name="type_code" class="form-select" required>
                                    <option value="" selected disabled>Select Type</option>
                                   
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Total Hours</label>
                                <input type="number" id="total_hours" name="total_hours" class="form-control" placeholder="Enter total hours" min="1" max="9999" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Date</label>
                                <input type="date" id="date" name="date" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Year</label>
                                <select id="year" name="year" class="form-select" required>
                                    <option value="" selected disabled>Select Year</option>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label required">Research Activities Description</label>
                                <textarea id="other_research_activities" name="other_research_activities" class="form-control" rows="3" placeholder="Enter detailed description of research activities" maxlength="1000" required></textarea>
                                <div class="text-end mt-1">
                                    <small class="text-muted">
                                        <span id="descCharCount">0</span> characters (Max: 1000 characters)
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-12" style="padding-top: 15px;">
                                <button type="button" id="btnAddResearchActivity" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-2"></i>
                                    Add Research Activity
                                </button>
                                <button type="button" id="btnUpdateResearchActivity" class="btn btn-warning btn-sm" style="display: none;">
                                    <i class="fas fa-edit me-2"></i>
                                    Update Research Activity
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
                                        Upload your filled Excel file to import multiple research activities at once.
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
                                <strong>Preview:</strong> Review the imported data below. Click "Confirm Import" to add all research activities or "Cancel" to discard.
                            </div>
                            <div class="table-responsive" style="max-height: 400px; overflow-y: auto; border: 1px solid #dee2e6; border-radius: 6px;">
                                <table class="table table-sm table-bordered table-hover mb-0" id="excelPreviewTable">
                                    <thead class="table-light" style="position: sticky; top: 0; z-index: 10;">
                                        <tr style="font-size: 11px;">
                                            <th>S.No</th>
                                            <th>Title</th>
                                            <th>Type</th>
                                            <th>Description</th>
                                            <th>Hours</th>
                                            <th>Date</th>
                                            <th>Year</th>
                                        </tr>
                                    </thead>
                                    <tbody id="excelPreviewBody" style="font-size: 11px;">
                                    </tbody>
                                </table>
                            </div>
                            <div class="mt-3 d-flex gap-2">
                                <button type="button" id="btnConfirmImport" class="btn btn-success btn-sm">
                                    <i class="fas fa-check me-2"></i>
                                    Confirm Import (<span id="excelRecordCount">0</span> activities)
                                </button>
                                <button type="button" id="btnCancelImport" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-times me-2"></i>
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>



                <!-- Research Activities List -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                            Research Activities Records
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="researchActivitiesList">
                            <!-- Research activities will be dynamically added here -->
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-microscope fa-2x mb-3"></i>
                                <p>No research activities added yet. Add your first research activity above.</p>
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
        var researchActivitiesRecords = [];
        var editingIndex = -1;
        var excelDataPreview = [];
        var otherResearchTypesMapping = {}; // Store TypeName -> TypeCode mapping

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

            // Add research activity button click handler
            $('#btnAddResearchActivity').click(function () {
                addResearchActivityRecord();
            });

            // Update research activity button click handler
            $('#btnUpdateResearchActivity').click(function () {
                updateResearchActivityRecord();
            });

            // Cancel edit button click handler
            $('#btnCancelEdit').click(function () {
                cancelEdit();
            });

            // Save all button click handler
            $('#btnSaveAll').click(function () {
                saveAllResearchActivitiesDetails();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Next button click handler
            $('#btnNext').click(function () {
                navigateToNextMenu();
            });

            // Character count for description
            $('#other_research_activities').on('input', function () {
                updateDescCharCount();
            });

            // Load year options and research activities data
            loadYearOptions();
            loadPublicationsType();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'title', 'type_code', 'other_research_activities', 
                'total_hours', 'date', 'year'
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

            // Validate total hours
            var totalHours = parseInt($('#total_hours').val());
            if (totalHours && (totalHours < 1 || totalHours > 9999)) {
                $('#total_hours').addClass('is-invalid');
                isValid = false;
            } else {
                $('#total_hours').removeClass('is-invalid');
            }

            return isValid;
        }

        function addResearchActivityRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var researchActivityData = {
                title: $('#title').val(),
                type_code: $('#type_code').val(),
                type_name: $('#type_code option:selected').text(),
                other_research_activities: $('#other_research_activities').val(),
                total_hours: $('#total_hours').val(),
                date: $('#date').val(),
                year: $('#year').val(),
                year_name: $('#year option:selected').text(),
                id: Date.now()
            };

            researchActivitiesRecords.push(researchActivityData);
            displayResearchActivitiesRecords();
            clearForm();
            showTopRightMessage('Research activity added successfully!');
        }

        function updateResearchActivityRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var researchActivityData = {
                title: $('#title').val(),
                type_code: $('#type_code').val(),
                type_name: $('#type_code option:selected').text(),
                other_research_activities: $('#other_research_activities').val(),
                total_hours: $('#total_hours').val(),
                date: $('#date').val(),
                year: $('#year').val(),
                year_name: $('#year option:selected').text(),
                id: researchActivitiesRecords[editingIndex].id
            };

            researchActivitiesRecords[editingIndex] = researchActivityData;
            displayResearchActivitiesRecords();
            clearForm();
            cancelEdit();
            showTopRightMessage('Research activity updated successfully!');
            
            // Call btnSaveAll click event after updating the record
            $('#btnSaveAll').click();
        }

        function editResearchActivityRecord(index) {
            var record = researchActivitiesRecords[index];
            
            // Fill form data
            $('#title').val(record.title);
            $('#type_code').val(record.type_code);
            $('#other_research_activities').val(record.other_research_activities);
            $('#total_hours').val(record.total_hours);
            $('#date').val(record.date);
            $('#year').val(record.year || record.year_code); // Handle both field names for backward compatibility
            
            // Update character count
            updateDescCharCount();
            
            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddResearchActivity').hide();
            $('#btnUpdateResearchActivity').show();
            $('#btnCancelEdit').show();
            
            // Highlight the form section
            var formCard = $('#title').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');
            
            // Remove highlight after 3 seconds
            setTimeout(function () {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', 'none');
            }, 3000);
        }

        function deleteResearchActivityRecord(index) {
            if (confirm('Are you sure you want to delete this research activity record?')) {
                researchActivitiesRecords.splice(index, 1);
                displayResearchActivitiesRecords();
                showTopRightMessage('Research activity record deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddResearchActivity').show();
            $('#btnUpdateResearchActivity').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#title').val('');
            $('#type_code').val('');
            $('#other_research_activities').val('');
            $('#total_hours').val('');
            $('#date').val('');
            $('#year').val('');
            
            // Reset character count
            updateDescCharCount();
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function updateDescCharCount() {
            var count = $('#other_research_activities').val().length;
            $('#descCharCount').text(count);
            
            if (count > 900) {
                $('#descCharCount').css('color', 'red');
            } else if (count > 800) {
                $('#descCharCount').css('color', 'orange');
            } else {
                $('#descCharCount').css('color', '');
            }
        }

        function displayResearchActivitiesRecords() {
            var container = $('#researchActivitiesList');
            
            if (researchActivitiesRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-microscope fa-2x mb-3"></i>
                        <p>No research activities added yet. Add your first research activity above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Title</th>
                                <th style="font-size: 12px; font-weight: 600;">Type</th>
                                <th style="font-size: 12px; font-weight: 600;">Description</th>
                                <th style="font-size: 12px; font-weight: 600;">Hours</th>
                                <th style="font-size: 12px; font-weight: 600;">Date</th>
                                <th style="font-size: 12px; font-weight: 600;">Year</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            researchActivitiesRecords.forEach(function (record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">${record.title ? (record.title.length > 20 ? record.title.substring(0, 20) + '...' : record.title) : '-'}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getTypeBadgeClass(record.type_code)}">${record.type_name || record.type_code}</span>
                        </td>
                        <td style="font-size: 12px;">${record.other_research_activities ? (record.other_research_activities.length > 30 ? record.other_research_activities.substring(0, 30) + '...' : record.other_research_activities) : '-'}</td>
                        <td style="font-size: 12px;">${record.total_hours || '-'}</td>
                        <td style="font-size: 12px;">${record.date ? formatDateForDisplay(record.date) : '-'}</td>
                        <td style="font-size: 12px;">
                            <span class="badge bg-info">${record.year_name || record.year || record.year_code}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editResearchActivityRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteResearchActivityRecord(${index})" title="Delete Record">
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

        function formatDateForDisplay(dateString) {
            if (dateString) {
                var date = new Date(dateString);
                return date.toLocaleDateString('en-US', { 
                    year: 'numeric', 
                    month: 'short', 
                    day: 'numeric' 
                });
            }
            return '';
        }

        function getTypeBadgeClass(type) {
            switch (type) {
                case 'CONSULTATION': return 'bg-primary';
                case 'REVIEW': return 'bg-info';
                case 'EVALUATION': return 'bg-success';
                case 'ASSESSMENT': return 'bg-warning';
                case 'ANALYSIS': return 'bg-secondary';
                case 'RESEARCH': return 'bg-danger';
                case 'DEVELOPMENT': return 'bg-dark';
                case 'TESTING': return 'bg-purple';
                default: return 'bg-light text-dark';
            }
        }

        function saveAllResearchActivitiesDetails() {
            if (researchActivitiesRecords.length === 0) {
                showErrorMessage('No research activity records to save');
                return;
            }

            $('#btnSaveAll').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

            $.ajax({
                url: '../../WebService.asmx/SaveOtherResearchActivitiesDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ formDataJson: JSON.stringify(researchActivitiesRecords) }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'Research activities saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save research activities');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save research activities');
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Error saving research activities: ' + error);
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
                            $('#year').find('option:not(:first)').remove();
                            
                            // Add new options from the web service
                            $.each(result, function (index, item) {
                                var option = $('<option></option>')
                                    .attr('value', item.YearCode || item.yearCode || item.year_code)
                                    .text(item.YearName || item.yearName || item.year_name || item.YearCode || item.yearCode);
                                $('#year').append(option);
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
                $('#year').append(option);
            }
        }

        function loadResearchActivitiesRecords() {
            $.ajax({
                url: '../../WebService.asmx/GetOtherResearchActivitiesDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        
                        // Process each record to add type names
                        if (result && result.length > 0) {
                            result.forEach(function(record) {
                                // If type_name is not provided, get it from dropdown options
                                if (!record.type_name && record.type_code) {
                                    $('#type_code option').each(function() {
                                        if ($(this).val() === record.type_code) {
                                            record.type_name = $(this).text();
                                            return false; // Break the loop
                                        }
                                    });
                                }
                                
                                // If year_name is not provided, get it from dropdown options
                                if (!record.year_name && (record.year || record.year_code)) {
                                    var yearValue = record.year || record.year_code;
                                    $('#year option').each(function() {
                                        if ($(this).val() === yearValue) {
                                            record.year_name = $(this).text();
                                            return false; // Break the loop
                                        }
                                    });
                                }
                            });
                        }
                        
                        researchActivitiesRecords = result || [];
                        displayResearchActivitiesRecords();
                        showTopRightMessage('Research activities data loaded successfully');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading research activities:', error);
                    showErrorMessage('Failed to load research activities data');
                }
            });
        }

        function showErrorMessage(message) {
            alert('Error: ' + message);
        }

        function showTopRightMessage(message) {
            var alertDiv = $('<div class="alert alert-success alert-dismissible fade show" style="position: fixed; top: 20px; right: 20px; z-index: 9999;">' +
                '<i class="fas fa-check-circle me-2"></i>' + message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                '</div>');
            
            $('body').append(alertDiv);
            
            setTimeout(function () {
                alertDiv.alert('close');
            }, 5000);
        }

        function navigateToPreviousMenu() {
            window.location.href = 'Affiliations.aspx';
        }

        function navigateToNextMenu() {
            window.location.href = 'ExperienceDetails.aspx';
        }

        function loadPublicationsType() {
            $.ajax({
                url: '../../WebService.asmx/GetPublicationType',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: "{publicationtype : 'OtherResearchActivities'}",
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            // Clear existing options except the first one
                            $('#type_code').find('option:not(:first)').remove();

                            // Add new options from the web service
                            $.each(result, function (index, item) {
                                var typeCode = item.TypeCode || item.TypeCode || item.TypeCode;
                                var typeName = item.TypeName || item.TypeName || item.TypeName;
                                
                                var option = $('<option></option>')
                                    .attr('value', typeCode)
                                    .text(typeName);
                                $('#type_code').append(option);
                                
                                // Store mapping for Excel import: TypeName -> TypeCode
                                otherResearchTypesMapping[typeName] = typeCode;
                            });
                        }

                        // Load publications records after publication types are loaded
                        loadResearchActivitiesRecords();
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading publication types:', error);
                    loadResearchActivitiesRecords();
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
                    'Title',
                    'Type',
                    'Description',
                    'Total Hours',
                    'Date (YYYY-MM-DD)',
                    'Year'
                ];

                // Get available research activity types from dropdown
                var availableTypes = [];
                $('#type_code option').each(function() {
                    var value = $(this).val();
                    if (value) {
                        availableTypes.push($(this).text());
                    }
                });

                var firstType = availableTypes.length > 0 ? availableTypes[0] : 'Consultation';
                var secondType = availableTypes.length > 1 ? availableTypes[1] : 'Review';

                // Get available years from dropdown
                var availableYears = [];
                $('#year option').each(function() {
                    var value = $(this).val();
                    if (value) {
                        availableYears.push($(this).text());
                    }
                });

                var firstYear = availableYears.length > 0 ? availableYears[0] : '2024-2025';
                var secondYear = availableYears.length > 1 ? availableYears[1] : '2023-2024';

                var sampleData1 = [
                    'Research Consultation for AI Project',
                    firstType,
                    'Provided expert consultation on artificial intelligence implementation strategies and best practices',
                    '40',
                    '2024-01-15',
                    firstYear
                ];

                var sampleData2 = [
                    'Technical Review of Machine Learning Paper',
                    secondType,
                    'Conducted thorough review of research paper on machine learning algorithms and provided detailed feedback',
                    '25',
                    '2024-02-20',
                    secondYear
                ];

                var typesString = availableTypes.length > 0 ? availableTypes.join(', ') : 'Consultation, Review, Evaluation, Assessment, Analysis, Research, Development, Testing';
                var yearsString = availableYears.length > 0 ? availableYears.join(', ') : '2024-2025, 2023-2024, 2022-2023';

                var instructions = [
                    'INSTRUCTIONS:',
                    '1. Fill your research activity data starting from Row 4',
                    '2. Delete these sample rows before uploading',
                    '3. Required fields: Title, Type, Description, Total Hours, Date, Year',
                    '4. Available Types: ' + typesString,
                    '5. Available Years: ' + yearsString,
                    '6. Date format: YYYY-MM-DD (e.g., 2024-01-15)',
                    '7. Total Hours: Number between 1-9999',
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
                    { wch: 35 }, // Title
                    { wch: 20 }, // Type
                    { wch: 50 }, // Description
                    { wch: 12 }, // Total Hours
                    { wch: 15 }, // Date
                    { wch: 15 }  // Year
                ];

                XLSX.utils.book_append_sheet(wb, ws, 'Other Research Activities');

                var today = new Date();
                var dateStr = today.getFullYear() + 
                             String(today.getMonth() + 1).padStart(2, '0') + 
                             String(today.getDate()).padStart(2, '0');
                var fileName = 'Other_Research_Activities_Template_' + dateStr + '.xlsx';

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

            console.log('Available Other Research Types Mapping:', otherResearchTypesMapping);

            for (var i = 1; i < jsonData.length; i++) {
                var row = jsonData[i];

                if (!row || row.length === 0) continue;
                if (row[0] && (row[0].toString().includes('INSTRUCTIONS') || 
                              row[0].toString().includes('Fill your research'))) {
                    continue;
                }

                var title = row[0] ? row[0].toString().trim() : '';
                var researchType = row[1] ? row[1].toString().trim() : '';
                var description = row[2] ? row[2].toString().trim() : '';
                var totalHours = row[3] ? row[3].toString().trim() : '';
                var date = row[4] ? row[4].toString().trim() : '';
                var year = row[5] ? row[5].toString().trim() : '';

                if (!title && !researchType && !description) {
                    continue;
                }

                if (!title || !researchType || !description || !totalHours || !date || !year) {
                    console.warn('Skipping row ' + (i + 1) + ': Missing required fields');
                    continue;
                }

                // Validate total hours
                var hoursNum = parseInt(totalHours);
                if (isNaN(hoursNum) || hoursNum < 1 || hoursNum > 9999) {
                    console.warn('Skipping row ' + (i + 1) + ': Invalid Total Hours "' + totalHours + '"');
                    continue;
                }

                // Map research type name to database TypeCode
                var researchTypeCode = otherResearchTypesMapping[researchType];

                // Case-insensitive fallback
                if (!researchTypeCode) {
                    for (var typeName in otherResearchTypesMapping) {
                        if (typeName.toLowerCase() === researchType.toLowerCase()) {
                            researchTypeCode = otherResearchTypesMapping[typeName];
                            researchType = typeName;
                            break;
                        }
                    }
                }

                if (!researchTypeCode) {
                    console.warn('Skipping row ' + (i + 1) + ': Invalid Research Type "' + researchType + '"');
                    continue;
                }

                // Find year code from dropdown
                var yearCode = null;
                var yearName = year;
                $('#year option').each(function() {
                    if ($(this).text() === year || $(this).val() === year) {
                        yearCode = $(this).val();
                        yearName = $(this).text();
                        return false;
                    }
                });

                if (!yearCode) {
                    console.warn('Skipping row ' + (i + 1) + ': Invalid Year "' + year + '"');
                    continue;
                }

                var researchActivityData = {
                    title: title,
                    type_code: researchTypeCode,
                    type_name: researchType,
                    other_research_activities: description,
                    total_hours: totalHours,
                    date: date,
                    year: yearCode,
                    year_name: yearName,
                    id: Date.now() + i
                };

                excelDataPreview.push(researchActivityData);
            }

            if (excelDataPreview.length === 0) {
                showErrorMessage('No valid data found in Excel file! Please check required fields.');
                return;
            }

            displayExcelPreview();
            showTopRightMessage('Found ' + excelDataPreview.length + ' research activity(ies) in Excel file!');
        }

        function displayExcelPreview() {
            var tbody = $('#excelPreviewBody');
            tbody.empty();

            excelDataPreview.forEach(function (record, index) {
                var row = `
                    <tr>
                        <td>${index + 1}</td>
                        <td title="${record.title}">${record.title.length > 25 ? record.title.substring(0, 25) + '...' : record.title}</td>
                        <td>${record.type_name || record.type_code}</td>
                        <td title="${record.other_research_activities}">${record.other_research_activities.length > 30 ? record.other_research_activities.substring(0, 30) + '...' : record.other_research_activities}</td>
                        <td>${record.total_hours}</td>
                        <td>${record.date}</td>
                        <td>${record.year_name || record.year}</td>
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
                researchActivitiesRecords.push(record);
            });

            displayResearchActivitiesRecords();

            showTopRightMessage('Importing ' + excelDataPreview.length + ' research activity(ies)...');

            setTimeout(function () {
                saveAllResearchActivitiesDetails();
            }, 500);

            cancelExcelImport();

            showTopRightMessage('Successfully imported ' + excelDataPreview.length + ' research activity(ies)!');
        }

        function cancelExcelImport() {
            excelDataPreview = [];
            $('#excelPreviewBody').empty();
            $('#excelPreviewSection').slideUp();
            $('#excelFileUpload').val('');
        }
    </script>
</asp:Content>
