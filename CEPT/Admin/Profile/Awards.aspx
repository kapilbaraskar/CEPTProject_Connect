<%@ Page Title="Awards Details" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="Awards.aspx.cs" Inherits="Admin_Profile_Awards" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="awards-tab" role="tabpanel">
                
                <!-- Main Header -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                            <i class="fas fa-trophy me-2" style="font-size: 1rem;"></i>
                            Awards & Recognition
                        </h5>
                    </div>
                </div>

                <!-- Add New Award Form -->
                <div class="card mb-4" id="awardForm">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                            Add New Award
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label required">Type</label>
                                <input type="text" id="type" name="type" class="form-control" placeholder="Enter award type" required maxlength="100">
                                <div class="text-end mt-1">
                                    <small class="text-muted">
                                        <span id="typeCharCount">0</span> characters (Max: 100 characters)
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Title</label>
                                <input type="text" id="title" name="title" class="form-control" placeholder="Enter award title" required maxlength="200">
                                <div class="text-end mt-1">
                                    <small class="text-muted">
                                        <span id="titleCharCount">0</span> characters (Max: 200 characters)
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label required">Description</label>
                                <textarea id="description" name="description" class="form-control" rows="3" placeholder="Enter award description" required maxlength="500"></textarea>
                                <div class="text-end mt-1">
                                    <small class="text-muted">
                                        <span id="descCharCount">0</span> characters (Max: 500 characters)
                                    </small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Date</label>
                                <input type="date" id="date" name="date" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Year Code</label>
                                <select id="year_code" name="year_code" class="form-select" required>
                                    <option value="" selected disabled>Select Year</option>
                                    <option value="2020">2020</option>
                                    <option value="2021">2021</option>
                                    <option value="2022">2022</option>
                                    <option value="2023">2023</option>
                                    <option value="2024">2024</option>
                                    <option value="2025">2025</option>
                                </select>
                            </div>
                            <div class="col-md-12" style="padding-top: 15px;">
                                <button type="button" id="btnAddAward" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-2"></i>
                                    Add Award
                                </button>
                                <button type="button" id="btnUpdateAward" class="btn btn-warning btn-sm" style="display: none;">
                                    <i class="fas fa-edit me-2"></i>
                                    Update Award
                                </button>
                                <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                    <i class="fas fa-times me-2"></i>
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Awards Records List -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                            Awards Records List
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="awardsRecordsList">
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-trophy fa-2x mb-3"></i>
                                <p>No awards added yet. Add your first award above.</p>
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
        var awardsRecords = [];
        var editingIndex = -1;

        $(document).ready(function () {
            // Add award button click handler
            $('#btnAddAward').click(function () {
                addAwardRecord();
            });

            // Update award button click handler
            $('#btnUpdateAward').click(function () {
                updateAwardRecord();
            });

            // Cancel edit button click handler
            $('#btnCancelEdit').click(function () {
                cancelEdit();
            });

            // Save all button click handler
            $('#btnSaveAll').click(function () {
                saveAllAwardsDetails();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Next button click handler
            $('#btnNext').click(function () {
                navigateToNextMenu();
            });

            // Character count for type
            $('#type').on('input', function () {
                updateTypeCharCount();
            });

            // Character count for title
            $('#title').on('input', function () {
                updateTitleCharCount();
            });

            // Character count for description
            $('#description').on('input', function () {
                updateDescCharCount();
            });

            // Load existing awards records
            loadAwardsRecords();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'type', 'title', 'description', 'date', 'year_code'
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

        function addAwardRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var awardData = {
                type: $('#type').val(),
                title: $('#title').val(),
                description: $('#description').val(),
                date: $('#date').val(),
                year_code: $('#year_code').val(),
                id: Date.now()
            };

            awardsRecords.push(awardData);
            displayAwardsRecords();
            clearForm();
            showTopRightMessage('Award added successfully!');
        }

        function updateAwardRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var awardData = {
                type: $('#type').val(),
                title: $('#title').val(),
                description: $('#description').val(),
                date: $('#date').val(),
                year_code: $('#year_code').val(),
                id: awardsRecords[editingIndex].id
            };

            awardsRecords[editingIndex] = awardData;
            displayAwardsRecords();
            clearForm();
            cancelEdit();
            showTopRightMessage('Award updated successfully!');
            
            // Call btnSaveAll click event after updating the record
            $('#btnSaveAll').click();
        }

        function editAwardRecord(index) {
            var record = awardsRecords[index];
            
            // Fill form data
            $('#type').val(record.type);
            $('#title').val(record.title);
            $('#description').val(record.description);
            $('#date').val(record.date);
            $('#year_code').val(record.year_code);
            
            // Update character counts
            updateTypeCharCount();
            updateTitleCharCount();
            updateDescCharCount();
            
            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddAward').hide();
            $('#btnUpdateAward').show();
            $('#btnCancelEdit').show();
            
            // Highlight the form section
            var formCard = $('#type').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');
            
            // Remove highlight after 3 seconds
            setTimeout(function () {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', '');
            }, 3000);

            // Scroll to the edit section
            try {
                var typeField = document.getElementById('type');
                if (typeField) {
                    typeField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } catch (e) {
                try {
                    $('html, body').animate({
                        scrollTop: $('#type').offset().top - 100
                    }, 1000);
                } catch (e2) {
                    window.scrollTo(0, 0);
                }
            }
            
            showTopRightMessage('Award loaded for editing!');
        }

        function deleteAwardRecord(index) {
            if (confirm('Are you sure you want to delete this award?')) {
                awardsRecords.splice(index, 1);
                displayAwardsRecords();
                showTopRightMessage('Award deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddAward').show();
            $('#btnUpdateAward').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#type').val('');
            $('#title').val('');
            $('#description').val('');
            $('#date').val('');
            $('#year_code').val('');
            
            // Reset character counts
            updateTypeCharCount();
            updateTitleCharCount();
            updateDescCharCount();
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function updateTypeCharCount() {
            var text = $('#type').val();
            var charCount = text.length;
            
            $('#typeCharCount').text(charCount);
            
            // Change color based on character limit
            var charCountElement = $('#typeCharCount');
            if (charCount > 90) {
                charCountElement.css('color', '#dc3545'); // Red for near limit
            } else if (charCount > 80) {
                charCountElement.css('color', '#ffc107'); // Yellow for warning
            } else {
                charCountElement.css('color', '#6c757d'); // Default muted color
            }
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
            if (charCount > 450) {
                charCountElement.css('color', '#dc3545'); // Red for near limit
            } else if (charCount > 400) {
                charCountElement.css('color', '#ffc107'); // Yellow for warning
            } else {
                charCountElement.css('color', '#6c757d'); // Default muted color
            }
        }

        function displayAwardsRecords() {
            var container = $('#awardsRecordsList');
            
            if (awardsRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-trophy fa-2x mb-3"></i>
                        <p>No awards added yet. Add your first award above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Type</th>
                                <th style="font-size: 12px; font-weight: 600;">Title</th>
                                <th style="font-size: 12px; font-weight: 600;">Description</th>
                                <th style="font-size: 12px; font-weight: 600;">Date</th>
                                <th style="font-size: 12px; font-weight: 600;">Year</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            awardsRecords.forEach(function (record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">
                            <span class="badge bg-primary">${record.type}</span>
                        </td>
                        <td style="font-size: 12px;">${record.title ? (record.title.length > 25 ? record.title.substring(0, 25) + '...' : record.title) : '-'}</td>
                        <td style="font-size: 12px;">${record.description ? (record.description.length > 30 ? record.description.substring(0, 30) + '...' : record.description) : '-'}</td>
                        <td style="font-size: 12px;">${formatDate(record.date)}</td>
                        <td style="font-size: 12px;">
                            <span class="badge bg-info">${record.year_code}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editAwardRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteAwardRecord(${index})" title="Delete Record">
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
            return date.toLocaleDateString('en-GB'); // DD/MM/YYYY format
        }

        function saveAllAwardsDetails() {
            if (awardsRecords.length === 0) {
                showErrorMessage('No awards to save');
                return;
            }

            $('#btnSaveAll').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

            $.ajax({
                url: '../../WebService.asmx/SaveAwardsDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ formDataJson: JSON.stringify(awardsRecords) }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'Awards saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save awards');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save awards');
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Error saving awards: ' + error);
                    console.error('AJAX Error:', xhr.responseText);
                },
                complete: function () {
                    $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
                }
            });
        }

        function loadAwardsRecords() {
            $.ajax({
                url: '../../WebService.asmx/GetAwardsDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            awardsRecords = result;
                            displayAwardsRecords();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading awards records:', error);
                }
            });
        }

        function navigateToPreviousMenu() {
            // Navigate to previous page (Research)
            window.location.href = 'Research.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page (if any)
            showTopRightMessage('Awards completed!');
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

