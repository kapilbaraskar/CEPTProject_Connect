<%@ Page Title="Training Program" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="TrainingProgram.aspx.cs" Inherits="Admin_Profile_TrainingProgram" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="training-program-tab" role="tabpanel">
                <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                        <i class="fas fa-chalkboard-teacher me-2" style="font-size: 1rem;"></i>
                        Training Programs
                    </h5>
                </div>

                <form id="trainingProgramForm" class="personal-details-form">
                    <!-- Add New Training Program Section -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                                Add New Training Program
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label required">Type Code</label>
                                    <select id="typeCode" name="typeCode" class="form-select" required>
                                        <option value="" selected disabled>Select Type</option>
                                        <option value="WORKSHOP">Workshop</option>
                                        <option value="SEMINAR">Seminar</option>
                                        <option value="CONFERENCE">Conference</option>
                                        <option value="TRAINING">Training</option>
                                        <option value="CERTIFICATION">Certification</option>
                                        <option value="WEBINAR">Webinar</option>
                                        <option value="COURSE">Course</option>
                                        <option value="OTHER">Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Title</label>
                                    <input type="text" id="title" name="title" class="form-control" placeholder="Enter training program title" required>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label required">Description</label>
                                    <textarea id="description" name="description" class="form-control" rows="3" placeholder="Enter detailed description of the training program" required></textarea>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label required">Duration (Days)</label>
                                    <input type="number" id="duration" name="duration" class="form-control" placeholder="Enter duration in days" min="1" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label required">Start Date</label>
                                    <input type="date" id="start_date" name="start_date" class="form-control" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label required">End Date</label>
                                    <input type="date" id="end_date" name="end_date" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Organizer</label>
                                    <input type="text" id="organizer" name="organizer" class="form-control" placeholder="Enter organizer name/institution" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Number of Participants</label>
                                    <input type="number" id="no_of_participants" name="no_of_participants" class="form-control" placeholder="Enter number of participants" min="1" required>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Certificate File Upload</label>
                                    <div class="file-upload-container">
                                        <input type="file" id="certificate" name="certificate" class="form-control" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" style="display: none;">
                                        <div class="file-upload-display">
                                            <button type="button" class="btn btn-outline-secondary btn-sm" onclick="document.getElementById('certificate').click()">
                                                <i class="fas fa-upload me-2"></i>
                                                Choose File
                                            </button>
                                            <span id="certificate-file-name" class="file-name-display">No file chosen</span>
                                        </div>
                                        <small class="text-muted">Supported formats: PDF, JPG, PNG, DOC, DOCX (Max 5MB)</small>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <button type="button" id="btnAddTraining" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus me-2"></i>
                                        Add Training Program
                                    </button>
                                    <button type="button" id="btnUpdateTraining" class="btn btn-warning btn-sm" style="display: none;">
                                        <i class="fas fa-edit me-2"></i>
                                        Update Training Program
                                    </button>
                                    <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                        <i class="fas fa-times me-2"></i>
                                        Cancel
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Training Programs List -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                                Training Programs Records
                            </h5>
                        </div>
                        <div class="card-body">
                            <div id="trainingProgramsList">
                                <!-- Training programs will be dynamically added here -->
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-chalkboard-teacher fa-2x mb-3"></i>
                                    <p>No training programs added yet. Add your first training program above.</p>
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

        .training-program-record {
            border: 1px solid #e9ecef;
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 12px;
            background: #fff;
            transition: all 0.2s ease;
        }

        .training-program-record:hover {
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            border-color: #007bff;
        }

        .training-program-record-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 10px;
        }

        .training-program-record-title {
            font-weight: 600;
            color: #495057;
            font-size: 14px;
            margin: 0;
        }

        .training-program-record-actions {
            display: flex;
            gap: 8px;
        }

        .training-program-record-details {
            font-size: 12px;
            color: #6c757d;
            line-height: 1.4;
        }

        .training-program-record-details .detail-item {
            margin-bottom: 4px;
        }

        .training-program-record-details .detail-label {
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
        var trainingPrograms = [];
        var editingIndex = -1;

        $(document).ready(function () {
            // Form validation
            $('#trainingProgramForm').on('submit', function (e) {
                e.preventDefault();
                validateForm();
            });

            // Save button click handler
            $('#btnSave').click(function () {
                saveAllTrainingPrograms();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Add training program button click handler
            $('#btnAddTraining').click(function () {
                addTrainingProgram();
            });

            // Update training program button click handler
            $('#btnUpdateTraining').click(function () {
                updateTrainingProgram();
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
            $('#certificate').change(function () {
                handleFileUpload(this);
            });

            // Load existing training programs
            loadTrainingPrograms();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'typeCode', 'title', 'description', 'duration', 'start_date', 'end_date', 
                'organizer', 'no_of_participants'
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

        function addTrainingProgram() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var trainingData = {
                typeCode: $('#typeCode').val(),
                title: $('#title').val(),
                description: $('#description').val(),
                duration: $('#duration').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                organizer: $('#organizer').val(),
                no_of_participants: $('#no_of_participants').val(),
                certificate: window.uploadedFileName || null,
                certificate_path: window.uploadedFilePath || null,
                id: Date.now() // Temporary ID for client-side management
            };

            trainingPrograms.push(trainingData);
            displayTrainingPrograms();
            clearForm();
            
            // Clear uploaded file info
            window.uploadedFileName = null;
            window.uploadedFilePath = null;
            
            showTopRightMessage('Training program added successfully!');
        }

        function updateTrainingProgram() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var trainingData = {
                typeCode: $('#typeCode').val(),
                title: $('#title').val(),
                description: $('#description').val(),
                duration: $('#duration').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                organizer: $('#organizer').val(),
                no_of_participants: $('#no_of_participants').val(),
                certificate: window.uploadedFileName || trainingPrograms[editingIndex].certificate,
                certificate_path: window.uploadedFilePath || trainingPrograms[editingIndex].certificate_path,
                id: trainingPrograms[editingIndex].id
            };

            trainingPrograms[editingIndex] = trainingData;
            displayTrainingPrograms();
            clearForm();
            cancelEdit();
            
            // Clear uploaded file info
            window.uploadedFileName = null;
            window.uploadedFilePath = null;
            
            showTopRightMessage('Training program updated successfully!');
            
            // Call btnSaveAll click event after updating the record
            $('#btnSave').click();
        }

        function editTrainingProgram(index) {
            var record = trainingPrograms[index];
            
            // Fill form data
            $('#typeCode').val(record.typeCode);
            $('#title').val(record.title);
            $('#description').val(record.description);
            $('#duration').val(record.duration);
            $('#start_date').val(record.start_date);
            $('#end_date').val(record.end_date);
            $('#organizer').val(record.organizer);
            $('#no_of_participants').val(record.no_of_participants);
            
            // Handle file display
            if (record.certificate) {
                $('#certificate-file-name').text(record.certificate).addClass('has-file');
            } else {
                $('#certificate-file-name').text('No file chosen').removeClass('has-file');
            }
            
            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddTraining').hide();
            $('#btnUpdateTraining').show();
            $('#btnCancelEdit').show();
            
            // Highlight the form section
            var formCard = $('#typeCode').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');
            
            // Remove highlight after 3 seconds
            setTimeout(function() {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', '');
            }, 3000);

            // Scroll to form
            try {
                var typeCodeField = document.getElementById('typeCode');
                if (typeCodeField) {
                    typeCodeField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } catch (e) {
                try {
                    $('html, body').animate({
                        scrollTop: $('#typeCode').offset().top - 100
                    }, 1000);
                } catch (e2) {
                    window.scrollTo(0, 0);
                }
            }
            
            showTopRightMessage('Training program loaded for editing!');
        }

        function deleteTrainingProgram(index) {
            if (confirm('Are you sure you want to delete this training program?')) {
                trainingPrograms.splice(index, 1);
                displayTrainingPrograms();
                showTopRightMessage('Training program deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddTraining').show();
            $('#btnUpdateTraining').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#typeCode').val('');
            $('#title').val('');
            $('#description').val('');
            $('#duration').val('');
            $('#start_date').val('');
            $('#end_date').val('');
            $('#organizer').val('');
            $('#no_of_participants').val('');
            $('#certificate').val('');
            $('#certificate-file-name').text('No file chosen').removeClass('has-file');
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function handleFileUpload(input) {
            var file = input.files[0];
            var fileNameDisplay = $('#certificate-file-name');
            
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
                UploadCertificateFile(input.id);
            }
            else {
                fileNameDisplay.text('No file chosen').removeClass('has-file');
            }
        }

        function displayTrainingPrograms() {
            var container = $('#trainingProgramsList');
            
            if (trainingPrograms.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-chalkboard-teacher fa-2x mb-3"></i>
                        <p>No training programs added yet. Add your first training program above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Duration</th>
                                <th style="font-size: 12px; font-weight: 600;">Start Date</th>
                                <th style="font-size: 12px; font-weight: 600;">End Date</th>
                                <th style="font-size: 12px; font-weight: 600;">Organizer</th>
                                <th style="font-size: 12px; font-weight: 600;">Participants</th>
                                <th style="font-size: 12px; font-weight: 600;">Certificate</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            trainingPrograms.forEach(function(record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">
                            <span class="badge bg-info">${record.typeCode}</span>
                        </td>
                        <td style="font-size: 12px; font-weight: 500;">${record.title}</td>
                        <td style="font-size: 12px; max-width: 200px;">
                            <div class="text-truncate" title="${record.description}">
                                ${record.description.length > 50 ? record.description.substring(0, 50) + '...' : record.description}
                            </div>
                        </td>
                        <td style="font-size: 12px;">${record.duration} days</td>
                        <td style="font-size: 12px;">${formatDate(record.start_date)}</td>
                        <td style="font-size: 12px;">${formatDate(record.end_date)}</td>
                        <td style="font-size: 12px;">${record.organizer}</td>
                        <td style="font-size: 12px;">${record.no_of_participants}</td>
                        <td style="font-size: 12px;">
                            ${record.certificate ?
                                `<div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-success"><i class="fas fa-file me-1"></i>${record.certificate}</span>
                                    ${record.certificate_path ?
                        `<button type="button" class="btn btn-outline-primary btn-sm" onclick="downloadFile('${record.certificate_path}', '${record.certificate}')" title="Download File">
                                            <i class="fas fa-download"></i>
                                        </button>` : ''
                                    }
                                </div>` : 
                                `<span class="badge bg-secondary"><i class="fas fa-times me-1"></i>No File</span>`
                            }
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editTrainingProgram(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteTrainingProgram(${index})" title="Delete Record">
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

        function saveAllTrainingPrograms() {
            if (trainingPrograms.length === 0) {
                showErrorMessage('Please add at least one training program');
                return;
            }

            // Show loading state
            $('#btnSave').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-2"></span>Saving...');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/SaveTrainingPrograms",
                data: JSON.stringify({ formDataJson: JSON.stringify(trainingPrograms) }),
                dataType: "json",
                success: function (response) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');

                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'All training programs saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save training programs');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save training programs');
                    }
                },
                error: function (xhr, status, error) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');
                    console.error('AJAX Error:', error);
                    showErrorMessage('An error occurred while saving training programs');
                }
            });
        }

        function loadTrainingPrograms() {
            // Load existing training programs from server
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetTrainingProgramsDetails",
                data: "{}",
                dataType: "json",
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            trainingPrograms = result;
                            displayTrainingPrograms();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading training programs:', error);
                }
            });
        }

        function UploadCertificateFile(fileInputId) {
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
                formData.append('documentType', 'TrainingProgram');
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
                            $('#certificate-file-name').text(responsedata.upfile).addClass('has-file');
                            showTopRightMessage('File uploaded successfully: ' + file.name);
                            
                            // Store file information for later use
                            window.uploadedFileName = responsedata.upfile;
                            window.uploadedFilePath = responsedata.upfile || responsedata.upfile;
                            
                            return true;
                        } else {
                            // Upload failed
                            showErrorMessage('File upload failed: ' + (responsedata.error || 'Unknown error'));
                            fileInput.val('');
                            $('#certificate-file-name').text('No file chosen').removeClass('has-file');
                            return false;
                        }
                    },
                    error: function(xhr, status, error) {
                        hideUploadProgress();
                        showErrorMessage('File upload error: ' + error);
                        fileInput.val('');
                        $('#certificate-file-name').text('No file chosen').removeClass('has-file');
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
            // Navigate to previous page
            window.location.href = 'EducationDetails.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page
            window.location.href = 'ExperienceDetails.aspx';
        }
    </script>

</asp:Content>