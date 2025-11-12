<%@ Page Title="Area of Expertise" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="AreaofExpertise.aspx.cs" Inherits="Admin_Profile_AreaofExpertise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
       <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="area-of-expertise-tab" role="tabpanel">
                
                <!-- Main Header -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                            <i class="fas fa-lightbulb me-2" style="font-size: 1rem;"></i>
                            Area of Expertise
                        </h5>
                    </div>
                </div>

                <!-- Add Expertise Form -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-plus me-2" style="font-size: 0.85rem;"></i>
                            Add Expertise Details
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label required">Expertise Area</label>
                                <input type="text" id="expertise_area" name="expertise_area" class="form-control" placeholder="Enter expertise area" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Skill Level</label>
                                <select id="skill_level" name="skill_level" class="form-select" required>
                                    <option value="" selected disabled>Select Skill Level</option>
                                    <option value="Beginner">Beginner</option>
                                    <option value="Intermediate">Intermediate</option>
                                    <option value="Advanced">Advanced</option>
                                    <option value="Expert">Expert</option>
                                    <option value="Master">Master</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Years of Experience</label>
                                <input type="number" id="years_of_experience" name="years_of_experience" class="form-control" placeholder="Enter years" min="0" max="50">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Certification</label>
                                <input type="text" id="certification" name="certification" class="form-control" placeholder="Enter certification details">
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Description</label>
                                <textarea id="description" name="description" class="form-control" rows="3" placeholder="Describe your expertise in this area"></textarea>
                            </div>
                            <div class="col-md-12" style="padding-top: 15px;">
                                <button type="button" id="btnAddExpertise" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-2"></i>
                                    Add Expertise
                                </button>
                                <button type="button" id="btnUpdateExpertise" class="btn btn-warning btn-sm" style="display: none;">
                                    <i class="fas fa-edit me-2"></i>
                                    Update Expertise
                                </button>
                                <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                    <i class="fas fa-times me-2"></i>
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Expertise Records List -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                            Expertise Records List
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="expertiseRecordsList">
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-lightbulb fa-2x mb-3"></i>
                                <p>No expertise details added yet. Add your first expertise above.</p>
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

        .btn-sm i {
            font-size: 10px;
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
        var expertiseRecords = [];
        var editingIndex = -1;

        $(document).ready(function () {
            // Add expertise button click handler
            $('#btnAddExpertise').click(function () {
                addExpertiseRecord();
            });

            // Update expertise button click handler
            $('#btnUpdateExpertise').click(function () {
                updateExpertiseRecord();
            });

        // Cancel edit button click handler
        $('#btnCancelEdit').click(function () {
            cancelEdit();
        });

            // Save all button click handler
            $('#btnSaveAll').click(function () {
                saveAllExpertiseDetails();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Next button click handler
            $('#btnNext').click(function () {
                navigateToNextMenu();
            });

            // Load existing expertise details
            loadExpertiseDetails();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'expertise_area', 'skill_level'
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

        function addExpertiseRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var expertiseData = {
                expertise_area: $('#expertise_area').val(),
                skill_level: $('#skill_level').val(),
                years_of_experience: $('#years_of_experience').val(),
                certification: $('#certification').val(),
                description: $('#description').val()
            };

        expertiseRecords.push(expertiseData);
        updateExpertiseTable();
        clearForm();
        showTopRightMessage('Expertise record added successfully!');
        }

        function updateExpertiseRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            if (editingIndex >= 0 && editingIndex < expertiseRecords.length) {
                expertiseRecords[editingIndex] = {
                    expertise_area: $('#expertise_area').val(),
                    skill_level: $('#skill_level').val(),
                    years_of_experience: $('#years_of_experience').val(),
                    certification: $('#certification').val(),
                    description: $('#description').val()
                };

                updateExpertiseTable();
                cancelEdit();
                
                // Call save all function to save updated record to database
                saveAllExpertiseDetails();
            }
        }

        function editExpertiseRecord(index) {
            if (index >= 0 && index < expertiseRecords.length) {
                var record = expertiseRecords[index];
                
                $('#expertise_area').val(record.expertise_area);
                $('#skill_level').val(record.skill_level);
                $('#years_of_experience').val(record.years_of_experience);
                $('#certification').val(record.certification);
                $('#description').val(record.description);

                editingIndex = index;
                
                $('#btnAddExpertise').hide();
                $('#btnUpdateExpertise').show();
                $('#btnCancelEdit').show();
                
                // Scroll to form
                $('html, body').animate({
                    scrollTop: $('.card-header').first().offset().top - 100
                }, 500);
            }
        }

        function deleteExpertiseRecord(index) {
            if (confirm('Are you sure you want to delete this expertise record?')) {
                expertiseRecords.splice(index, 1);
                updateExpertiseTable();
                showTopRightMessage('Expertise record deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            clearForm();
            $('#btnAddExpertise').show();
            $('#btnUpdateExpertise').hide();
            $('#btnCancelEdit').hide();
        }

        function clearForm() {
            $('#expertise_area').val('');
            $('#skill_level').val('');
            $('#years_of_experience').val('');
            $('#certification').val('');
            $('#description').val('');

            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function updateExpertiseTable() {
            var container = $('#expertiseRecordsList');
            
            if (expertiseRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-lightbulb fa-2x mb-3"></i>
                        <p>No expertise details added yet. Add your first expertise above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Expertise Area</th>
                                <th style="font-size: 12px; font-weight: 600;">Skill Level</th>
                                <th style="font-size: 12px; font-weight: 600;">Years of Experience</th>
                                <th style="font-size: 12px; font-weight: 600;">Certification</th>
                                <th style="font-size: 12px; font-weight: 600;">Description</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            expertiseRecords.forEach(function (record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">${record.expertise_area || '-'}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getSkillLevelBadgeClass(record.skill_level)}">${record.skill_level || '-'}</span>
                        </td>
                        <td style="font-size: 12px;">${record.years_of_experience || '-'}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${record.certification ? 'bg-success' : 'bg-secondary'}">${record.certification ? 'Yes' : 'No'}</span>
                        </td>
                        <td style="font-size: 12px;">${record.description ? (record.description.length > 50 ? record.description.substring(0, 50) + '...' : record.description) : '-'}</td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editExpertiseRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteExpertiseRecord(${index})" title="Delete Record">
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

        function getSkillLevelBadgeClass(skillLevel) {
            switch (skillLevel) {
                case 'Beginner': return 'bg-secondary';
                case 'Intermediate': return 'bg-warning';
                case 'Advanced': return 'bg-success';
                case 'Expert': return 'bg-primary';
                default: return 'bg-secondary';
            }
        }

        function saveAllExpertiseDetails() {
            if (expertiseRecords.length === 0) {
                showErrorMessage('No expertise records to save');
                return;
            }

            $('#btnSaveAll').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

            $.ajax({
                url: '../../WebService.asmx/SaveExpertiseDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ formDataJson: JSON.stringify(expertiseRecords) }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                    if (result.success) {
                        showTopRightMessage(result.message || 'Expertise details saved successfully!');
                        $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save expertise details');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save expertise details');
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Error saving expertise details: ' + error);
                    console.error('AJAX Error:', xhr.responseText);
                },
                complete: function () {
                    $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All Expertise');
                }
            });
        }

        function loadExpertiseDetails() {
            $.ajax({
                url: '../../WebService.asmx/GetExpertiseDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            expertiseRecords = result;
                            updateExpertiseTable();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading expertise details:', error);
                }
            });
        }

        function navigateToPreviousMenu() {
            // Navigate to previous page (Bank Account Details)
            window.location.href = 'BankAccountDetails.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page (if any)
            showTopRightMessage('Expertise details completed!');
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

