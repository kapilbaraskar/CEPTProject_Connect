<%@ Page Title="Affiliations" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="Affiliations.aspx.cs" Inherits="Admin_Profile_Affiliations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Professional Affiliations
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="affiliations-tab" role="tabpanel">
                
                <!-- Main Header -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                            <i class="fas fa-users me-2" style="font-size: 1rem;"></i>
                            Professional Affiliations
                        </h5>
                    </div>
                </div>


                <!-- Add New Affiliation Form -->
                <div class="card mb-4" id="affiliationForm">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                            Add New Professional Affiliation
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label required">Organization Name</label>
                                <input type="text" id="organization_name" name="organization_name" class="form-control" placeholder="Enter organization name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Position/Title</label>
                                <input type="text" id="position_title" name="position_title" class="form-control" placeholder="Enter your position or title" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Affiliation Type</label>
                                <select id="affiliation_type" name="affiliation_type" class="form-select" required>
                                    <option value="" selected disabled>Select Type</option>
                                    <option value="PROFESSIONAL">Professional Association</option>
                                    <option value="ACADEMIC">Academic Institution</option>
                                    <option value="RESEARCH">Research Organization</option>
                                    <option value="GOVERNMENT">Government Body</option>
                                    <option value="NONPROFIT">Non-Profit Organization</option>
                                    <option value="INDUSTRY">Industry Association</option>
                                    <option value="INTERNATIONAL">International Organization</option>
                                    <option value="OTHER">Other</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Membership Level</label>
                                <select id="membership_level" name="membership_level" class="form-select" required>
                                    <option value="" selected disabled>Select Level</option>
                                    <option value="MEMBER">Member</option>
                                    <option value="ASSOCIATE">Associate</option>
                                    <option value="FELLOW">Fellow</option>
                                    <option value="STUDENT">Student Member</option>
                                    <option value="LIFETIME">Lifetime Member</option>
                                    <option value="HONORARY">Honorary Member</option>
                                    <option value="BOARD">Board Member</option>
                                    <option value="COMMITTEE">Committee Member</option>
                                    <option value="OTHER">Other</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Start Date</label>
                                <input type="month" id="start_date" name="start_date" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">End Date</label>
                                <input type="month" id="end_date" name="end_date" class="form-control">
                                <small class="text-muted">Leave empty if currently active</small>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Membership Number</label>
                                <input type="text" id="membership_number" name="membership_number" class="form-control" placeholder="Enter membership number (if applicable)">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Status</label>
                                <select id="status" name="status" class="form-select">
                                    <option value="ACTIVE">Active</option>
                                    <option value="INACTIVE">Inactive</option>
                                    <option value="EXPIRED">Expired</option>
                                    <option value="SUSPENDED">Suspended</option>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Description</label>
                                <textarea id="description" name="description" class="form-control" rows="3" placeholder="Enter description of your role or responsibilities" maxlength="500"></textarea>
                                <div class="text-end mt-1">
                                    <small class="text-muted">
                                        <span id="descCharCount">0</span> characters (Max: 500 characters)
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-12" style="padding-top: 15px;">
                                <button type="button" id="btnAddAffiliation" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-2"></i>
                                    Add Affiliation
                                </button>
                                <button type="button" id="btnUpdateAffiliation" class="btn btn-warning btn-sm" style="display: none;">
                                    <i class="fas fa-edit me-2"></i>
                                    Update Affiliation
                                </button>
                                <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                    <i class="fas fa-times me-2"></i>
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Affiliations List -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                            Professional Affiliations Records
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="affiliationsList">
                            <!-- Affiliations will be dynamically added here -->
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-users fa-2x mb-3"></i>
                                <p>No professional affiliations added yet. Add your first affiliation above.</p>
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
        var affiliationsRecords = [];
        var editingIndex = -1;

        $(document).ready(function () {
            // Add affiliation button click handler
            $('#btnAddAffiliation').click(function () {
                addAffiliationRecord();
            });

            // Update affiliation button click handler
            $('#btnUpdateAffiliation').click(function () {
                updateAffiliationRecord();
            });

            // Cancel edit button click handler
            $('#btnCancelEdit').click(function () {
                cancelEdit();
            });

            // Save all button click handler
            $('#btnSaveAll').click(function () {
                saveAllAffiliationsDetails();
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
            $('#description').on('input', function () {
                updateDescCharCount();
            });

            // Load affiliations data on page load
            loadAffiliationsRecords();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'organization_name', 'position_title', 'affiliation_type', 
                'membership_level', 'start_date'
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

            // Validate end date if provided
            var startDate = $('#start_date').val();
            var endDate = $('#end_date').val();
            if (endDate && startDate && endDate < startDate) {
                $('#end_date').addClass('is-invalid');
                isValid = false;
            } else {
                $('#end_date').removeClass('is-invalid');
            }

            return isValid;
        }

        function addAffiliationRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var affiliationData = {
                organization_name: $('#organization_name').val(),
                position_title: $('#position_title').val(),
                affiliation_type: $('#affiliation_type').val(),
                affiliation_type_name: $('#affiliation_type option:selected').text(),
                membership_level: $('#membership_level').val(),
                membership_level_name: $('#membership_level option:selected').text(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                membership_number: $('#membership_number').val(),
                status: $('#status').val(),
                status_name: $('#status option:selected').text(),
                description: $('#description').val(),
                id: Date.now()
            };

            affiliationsRecords.push(affiliationData);
            displayAffiliationsRecords();
            clearForm();
            showTopRightMessage('Professional affiliation added successfully!');
        }

        function updateAffiliationRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var affiliationData = {
                organization_name: $('#organization_name').val(),
                position_title: $('#position_title').val(),
                affiliation_type: $('#affiliation_type').val(),
                affiliation_type_name: $('#affiliation_type option:selected').text(),
                membership_level: $('#membership_level').val(),
                membership_level_name: $('#membership_level option:selected').text(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                membership_number: $('#membership_number').val(),
                status: $('#status').val(),
                status_name: $('#status option:selected').text(),
                description: $('#description').val(),
                id: affiliationsRecords[editingIndex].id
            };

            affiliationsRecords[editingIndex] = affiliationData;
            displayAffiliationsRecords();
            clearForm();
            cancelEdit();
            showTopRightMessage('Professional affiliation updated successfully!');
            
            // Call btnSaveAll click event after updating the record
            $('#btnSaveAll').click();
        }

        function editAffiliationRecord(index) {
            var record = affiliationsRecords[index];
            
            // Fill form data
            $('#organization_name').val(record.organization_name);
            $('#position_title').val(record.position_title);
            $('#affiliation_type').val(record.affiliation_type);
            $('#membership_level').val(record.membership_level);
            $('#start_date').val(record.start_date);
            $('#end_date').val(record.end_date);
            $('#membership_number').val(record.membership_number);
            $('#status').val(record.status);
            $('#description').val(record.description);
            
            // Update character count
            updateDescCharCount();
            
            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddAffiliation').hide();
            $('#btnUpdateAffiliation').show();
            $('#btnCancelEdit').show();
            
            // Highlight the form section
            var formCard = $('#organization_name').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');
            
            // Remove highlight after 3 seconds
            setTimeout(function () {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', 'none');
            }, 3000);
        }

        function deleteAffiliationRecord(index) {
            if (confirm('Are you sure you want to delete this professional affiliation record?')) {
                affiliationsRecords.splice(index, 1);
                displayAffiliationsRecords();
                showTopRightMessage('Professional affiliation record deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddAffiliation').show();
            $('#btnUpdateAffiliation').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#organization_name').val('');
            $('#position_title').val('');
            $('#affiliation_type').val('');
            $('#membership_level').val('');
            $('#start_date').val('');
            $('#end_date').val('');
            $('#membership_number').val('');
            $('#status').val('ACTIVE');
            $('#description').val('');
            
            // Reset character count
            updateDescCharCount();
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function updateDescCharCount() {
            var count = $('#description').val().length;
            $('#descCharCount').text(count);
            
            if (count > 450) {
                $('#descCharCount').css('color', 'red');
            } else if (count > 400) {
                $('#descCharCount').css('color', 'orange');
            } else {
                $('#descCharCount').css('color', '');
            }
        }

        function displayAffiliationsRecords() {
            var container = $('#affiliationsList');
            
            if (affiliationsRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-users fa-2x mb-3"></i>
                        <p>No professional affiliations added yet. Add your first affiliation above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Position</th>
                                <th style="font-size: 12px; font-weight: 600;">Type</th>
                                <th style="font-size: 12px; font-weight: 600;">Level</th>
                                <th style="font-size: 12px; font-weight: 600;">Duration</th>
                                <th style="font-size: 12px; font-weight: 600;">Status</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            affiliationsRecords.forEach(function (record, index) {
                var duration = formatDuration(record.start_date, record.end_date);
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">${record.organization_name ? (record.organization_name.length > 20 ? record.organization_name.substring(0, 20) + '...' : record.organization_name) : '-'}</td>
                        <td style="font-size: 12px;">${record.position_title ? (record.position_title.length > 15 ? record.position_title.substring(0, 15) + '...' : record.position_title) : '-'}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getAffiliationTypeBadgeClass(record.affiliation_type)}">${record.affiliation_type_name || record.affiliation_type}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getMembershipLevelBadgeClass(record.membership_level)}">${record.membership_level_name || record.membership_level}</span>
                        </td>
                        <td style="font-size: 12px;">${duration}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getStatusBadgeClass(record.status)}">${record.status_name || record.status}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editAffiliationRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteAffiliationRecord(${index})" title="Delete Record">
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

        function formatDuration(startDate, endDate) {
            if (!startDate) return '-';
            
            var start = formatDateForDisplay(startDate);
            var end = endDate ? formatDateForDisplay(endDate) : 'Present';
            return start + ' to ' + end;
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

        function getAffiliationTypeBadgeClass(type) {
            switch (type) {
                case 'PROFESSIONAL': return 'bg-primary';
                case 'ACADEMIC': return 'bg-info';
                case 'RESEARCH': return 'bg-success';
                case 'GOVERNMENT': return 'bg-warning';
                case 'NONPROFIT': return 'bg-secondary';
                case 'INDUSTRY': return 'bg-dark';
                case 'INTERNATIONAL': return 'bg-danger';
                default: return 'bg-light text-dark';
            }
        }

        function getMembershipLevelBadgeClass(level) {
            switch (level) {
                case 'FELLOW': return 'bg-danger';
                case 'BOARD': return 'bg-warning';
                case 'COMMITTEE': return 'bg-info';
                case 'MEMBER': return 'bg-primary';
                case 'ASSOCIATE': return 'bg-secondary';
                case 'STUDENT': return 'bg-success';
                case 'LIFETIME': return 'bg-dark';
                case 'HONORARY': return 'bg-purple';
                default: return 'bg-light text-dark';
            }
        }

        function getStatusBadgeClass(status) {
            switch (status) {
                case 'ACTIVE': return 'bg-success';
                case 'INACTIVE': return 'bg-secondary';
                case 'EXPIRED': return 'bg-danger';
                case 'SUSPENDED': return 'bg-warning';
                default: return 'bg-light text-dark';
            }
        }

        function saveAllAffiliationsDetails() {
            if (affiliationsRecords.length === 0) {
                showErrorMessage('No affiliation records to save');
                return;
            }

            $('#btnSaveAll').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

            $.ajax({
                url: '../../WebService.asmx/SaveAffiliationsDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ formDataJson: JSON.stringify(affiliationsRecords) }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'Professional affiliations saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save professional affiliations');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save professional affiliations');
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Error saving professional affiliations: ' + error);
                    console.error('AJAX Error:', xhr.responseText);
                },
                complete: function () {
                    $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
                }
            });
        }

        function loadAffiliationsRecords() {
            $.ajax({
                url: '../../WebService.asmx/GetAffiliationsDetails',
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
                                // If affiliation_type_name is not provided, get it from dropdown options
                                if (!record.affiliation_type_name && record.affiliation_type) {
                                    $('#affiliation_type option').each(function() {
                                        if ($(this).val() === record.affiliation_type) {
                                            record.affiliation_type_name = $(this).text();
                                            return false; // Break the loop
                                        }
                                    });
                                }
                                
                                // If membership_level_name is not provided, get it from dropdown options
                                if (!record.membership_level_name && record.membership_level) {
                                    $('#membership_level option').each(function() {
                                        if ($(this).val() === record.membership_level) {
                                            record.membership_level_name = $(this).text();
                                            return false; // Break the loop
                                        }
                                    });
                                }
                                
                                // If status_name is not provided, get it from dropdown options
                                if (!record.status_name && record.status) {
                                    $('#status option').each(function() {
                                        if ($(this).val() === record.status) {
                                            record.status_name = $(this).text();
                                            return false; // Break the loop
                                        }
                                    });
                                }
                            });
                        }
                        
                        affiliationsRecords = result || [];
                        displayAffiliationsRecords();
                        showTopRightMessage('Professional affiliations data loaded successfully');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading affiliations:', error);
                    showErrorMessage('Failed to load professional affiliations data');
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
            window.location.href = 'Conferences.aspx';
        }

        function navigateToNextMenu() {
            window.location.href = 'ExperienceDetails.aspx';
        }
    </script>
</asp:Content>
