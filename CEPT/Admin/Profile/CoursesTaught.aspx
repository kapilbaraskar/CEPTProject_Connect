<%@ Page Title="Courses Taught" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="CoursesTaught.aspx.cs" Inherits="Admin_Profile_CoursesTaught" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
  <div class="personal-details-container">
    <div class="tab-content">
        <div class="tab-pane fade show active" id="courses-taught-tab" role="tabpanel">
            
            <!-- Main Header -->
            <div class="card mb-4">
                <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                        <i class="fas fa-graduation-cap me-2" style="font-size: 1rem;"></i>
                        Courses Taught
                    </h5>
                </div>
            </div>

            <!-- Add New Course Form -->
            <div class="card mb-4" id="courseForm" style="display:none;">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                        Add New Course
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label required">Course Code</label>
                            <select id="course_code" name="course_code" class="form-select" required>
                                <option value="" selected disabled>Select Course Code</option>
                                <option value="CS101">CS101 - Introduction to Computer Science</option>
                                <option value="CS102">CS102 - Programming Fundamentals</option>
                                <option value="CS201">CS201 - Data Structures</option>
                                <option value="CS202">CS202 - Algorithms</option>
                                <option value="CS301">CS301 - Database Systems</option>
                                <option value="CS302">CS302 - Software Engineering</option>
                                <option value="CS401">CS401 - Web Development</option>
                                <option value="CS402">CS402 - Mobile App Development</option>
                                <option value="MATH101">MATH101 - Calculus I</option>
                                <option value="MATH102">MATH102 - Calculus II</option>
                                <option value="PHYS101">PHYS101 - Physics I</option>
                                <option value="PHYS102">PHYS102 - Physics II</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Course Title</label>
                            <input type="text" id="title" name="title" class="form-control" placeholder="Enter course title" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Semester Year</label>
                            <select id="semester_year" name="semester_year" class="form-select" required>
                                <option value="" selected disabled>Select Year</option>
                                <option value="2020">2020</option>
                                <option value="2021">2021</option>
                                <option value="2022">2022</option>
                                <option value="2023">2023</option>
                                <option value="2024">2024</option>
                                <option value="2025">2025</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Semester Type</label>
                            <select id="semester_type" name="semester_type" class="form-select" required>
                                <option value="" selected disabled>Select Semester</option>
                                <option value="Fall">Fall</option>
                                <option value="Spring">Spring</option>
                                <option value="Summer">Summer</option>
                                <option value="Winter">Winter</option>
                            </select>
                        </div>
                        <div class="col-md-12" style="padding-top: 15px;">
                            <button type="button" id="btnAddCourse" class="btn btn-primary btn-sm">
                                <i class="fas fa-plus me-2"></i>
                                Add Course
                            </button>
                            <button type="button" id="btnUpdateCourse" class="btn btn-warning btn-sm" style="display: none;">
                                <i class="fas fa-edit me-2"></i>
                                Update Course
                            </button>
                            <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                <i class="fas fa-times me-2"></i>
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Courses Records List -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                        Courses Records List
                    </h5>
                </div>
                <div class="card-body">
                    <p><b> Note: Course Taught data will be retrieved</b></p>
                    <div id="coursesRecordsList">
                        <div class="text-center text-muted py-4">
                            <i class="fas fa-graduation-cap fa-2x mb-3"></i>
                            <p>No courses added yet. Add your first course above.</p>
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

    .btn-warning {
        background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
        border-color: #ffc107;
        color: #212529;
        font-weight: 600;
    }

    .btn-warning:hover {
        background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%);
        border-color: #e0a800;
        transform: translateY(-1px);
        box-shadow: 0 2px 4px rgba(255, 193, 7, 0.3);
        color: #212529;
    }

    .btn-warning:disabled {
        background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
        border-color: #ffc107;
        opacity: 0.6;
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
        var coursesRecords = [];
        var editingIndex = -1;
        var publishedCourses = []; // Track which courses have been published

        $(document).ready(function () {
            // Add course button click handler
            $('#btnAddCourse').click(function () {
                addCourseRecord();
            });

            // Update course button click handler
            $('#btnUpdateCourse').click(function () {
                updateCourseRecord();
            });

            // Cancel edit button click handler
            $('#btnCancelEdit').click(function () {
                cancelEdit();
            });

            // Save all button click handler
            $('#btnSaveAll').click(function () {
                saveAllCoursesDetails();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Next button click handler
            $('#btnNext').click(function () {
                navigateToNextMenu();
            });

            // Load existing courses records
            loadCoursesRecords();
            
            // Load previously published courses
            loadPublishedCourses();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'course_code', 'title', 'semester_year', 'semester_type'
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

        function addCourseRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var courseData = {
                course_code: $('#course_code').val(),
                title: $('#title').val(),
                semester_year: $('#semester_year').val(),
                semester_type: $('#semester_type').val(),
                is_active: 'N', // Default to publish (N)
                id: Date.now()
            };

            coursesRecords.push(courseData);
            displayCoursesRecords();
            clearForm();
            showTopRightMessage('Course record added successfully!');
        }

        function updateCourseRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var courseData = {
                course_code: $('#course_code').val(),
                title: $('#title').val(),
                semester_year: $('#semester_year').val(),
                semester_type: $('#semester_type').val(),
                is_active: coursesRecords[editingIndex].is_active || 'N', 
                id: coursesRecords[editingIndex].id
            };

            coursesRecords[editingIndex] = courseData;
            displayCoursesRecords();
            clearForm();
            cancelEdit();
            showTopRightMessage('Course record updated successfully!');
        }

        function editCourseRecord(index) {
            var record = coursesRecords[index];
            
            // Fill form data
            $('#course_code').val(record.course_code);
            $('#title').val(record.title);
            $('#semester_year').val(record.semester_year);
            $('#semester_type').val(record.semester_type);
            
            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddCourse').hide();
            $('#btnUpdateCourse').show();
            $('#btnCancelEdit').show();
            
            // Highlight the form section
            var formCard = $('#course_code').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');
            
            // Remove highlight after 3 seconds
            setTimeout(function () {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', '');
            }, 3000);

            // Scroll to the edit section
            try {
                var courseField = document.getElementById('course_code');
                if (courseField) {
                    courseField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } catch (e) {
                try {
                    $('html, body').animate({
                        scrollTop: $('#course_code').offset().top - 100
                    }, 1000);
                } catch (e2) {
                    window.scrollTo(0, 0);
                }
            }
            
            showTopRightMessage('Course record loaded for editing!');
        }

        function publishSingleCourse(index,type_data) {
            var record = coursesRecords[index];
            
            // Show confirmation dialog
            var action = type_data == 'Y' ? 'publish' : 'un-publish';
            var message = type_data == 'Y' 
                ? `Are you sure you want to publish "${record.title}" (${record.course_code})? This will make it publicly available.`
                : `Are you sure you want to un-publish "${record.title}" (${record.course_code})? This will remove it from public view.`;
            
            if (!confirm(message)) {
                return;
            }

            // Disable the button to prevent multiple clicks
            var button = event.target.closest('button');
            button.disabled = true;
            var loadingText = type_data == 'Y' ? 'Publishing...' : 'Un-publishing...';
            button.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>' + loadingText;

            $.ajax({
                url: '../../WebService.asmx/PublishSingleCourse',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: "{course_code : '" + record.course_code + "',semester_year: '" + record.semester_year + "',semester_type:'" + record.semester_type + "',is_active:'" + type_data+"'}",
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result == '1') {
                            if (type_data == 'Y') {
                                // Publishing course
                                showTopRightMessage(`Course "${record.title}" published successfully!`);
                                // Update the record's is_active status
                                coursesRecords[index].is_active = 'Y';
                                // Refresh the table display to show updated button
                                displayCoursesRecords();
                            } else {
                                // Un-publishing course
                                showTopRightMessage(`Course "${record.title}" un-published successfully!`);
                                // Update the record's is_active status
                                coursesRecords[index].is_active = 'N';
                                // Refresh the table display to show updated button
                                displayCoursesRecords();
                            }
                        } else {
                            showErrorMessage(result.message || 'Failed to update course status');
                            // Reset button
                            button.disabled = false;
                            if (type_data == 'Y') {
                                button.innerHTML = '<i class="fas fa-globe me-1"></i>Publish';
                            } else {
                                button.innerHTML = '<i class="fas fa-times-circle me-1"></i>Un-Publish';
                            }
                        }
                    } else {
                        showErrorMessage('Failed to update course status');
                        // Reset button
                        button.disabled = false;
                        if (type_data == 'Y') {
                            button.innerHTML = '<i class="fas fa-globe me-1"></i>Publish';
                        } else {
                            button.innerHTML = '<i class="fas fa-times-circle me-1"></i>Un-Publish';
                        }
                    }
                },
                error: function (xhr, status, error) {
                    var errorMessage = type_data == 'Y' ? 'Error publishing course: ' : 'Error un-publishing course: ';
                    showErrorMessage(errorMessage + error);
                    console.error('AJAX Error:', xhr.responseText);
                    // Reset button
                    button.disabled = false;
                    if (type_data == 'Y') {
                        button.innerHTML = '<i class="fas fa-globe me-1"></i>Publish';
                    } else {
                        button.innerHTML = '<i class="fas fa-times-circle me-1"></i>Un-Publish';
                    }
                }
            });
        }

        function deleteCourseRecord(index) {
            if (confirm('Are you sure you want to delete this course record?')) {
                coursesRecords.splice(index, 1);
                displayCoursesRecords();
                showTopRightMessage('Course record deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddCourse').show();
            $('#btnUpdateCourse').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#course_code').val('');
            $('#title').val('');
            $('#semester_year').val('');
            $('#semester_type').val('');
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function displayCoursesRecords() {
            var container = $('#coursesRecordsList');
            
            if (coursesRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-graduation-cap fa-2x mb-3"></i>
                        <p>No courses added yet. Add your first course above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;display:none;">id</th>
                                <th style="font-size: 12px; font-weight: 600;">Course Code</th>
                                <th style="font-size: 12px; font-weight: 600;">Title</th>
                                <th style="font-size: 12px; font-weight: 600;">Semester Year</th>
                                <th style="font-size: 12px; font-weight: 600;">Semester Type</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            coursesRecords.forEach(function (record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px; display:none;">${record.sr_no}</td>
                        <td style="font-size: 12px;">
                            <span class="badge bg-primary">${record.course_code}</span>
                        </td>
                        <td style="font-size: 12px;">${record.title}</td>
                        <td style="font-size: 12px;">${record.semester_year}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getSemesterTypeBadgeClass(record.semester_type)}">${record.semester_type}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                ${record.is_active == 'Y' ?
                                    '<button type="button" class="btn btn-success btn-sm" title="Un-Publish This Course" onclick="publishSingleCourse(' + index + ', \'N\')">' +
                                        '<i class="fas fa-times-circle me-1"></i>Un-Publish' +
                                    '</button>' :
                                    '<button type="button" class="btn btn-warning btn-sm" onclick="publishSingleCourse(' + index + ', \'Y\')" title="Publish This Course">' +
                                        '<i class="fas fa-globe me-1"></i>Publish' +
                                    '</button>'
                                }
                        
                                <button type="button" style='display:none;' class="btn btn-primary btn-sm" onclick="editCourseRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteCourseRecord(${index})" title="Delete Record">
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

        function getSemesterTypeBadgeClass(semesterType) {
            switch (semesterType) {
                case 'Monsoon': return 'bg-warning';
                case 'Spring': return 'bg-success';
                case 'Summer': return 'bg-info';
                case 'Winter': return 'bg-secondary';
                default: return 'bg-secondary';
            }
        }

        function saveAllCoursesDetails() {
            if (coursesRecords.length === 0) {
                showErrorMessage('No course records to save');
                return;
            }

            // Set publish/un-publish flags for all courses
            // N for publish, Y for unpublish
            coursesRecords.forEach(function(record) {
                if (!record.hasOwnProperty('is_active')) {
                    record.is_active = 'N'; // Default to publish (N)
                }
            });

            $('#btnSaveAll').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

            $.ajax({
                url: '../../WebService.asmx/SaveCourseTaughtDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ formDataJson: JSON.stringify(coursesRecords) }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'Courses details saved successfully with publish/un-publish flags!');
                            $('#btnNext').prop('disabled', false);
                            // Refresh the table to show updated button states
                            displayCoursesRecords();
                        } else {
                            showErrorMessage(result.message || 'Failed to save courses details');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save courses details');
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Error saving courses details: ' + error);
                    console.error('AJAX Error:', xhr.responseText);
                },
                complete: function () {
                    $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
                }
            });
        }

        function loadCoursesRecords() {
            $.ajax({
                url: '../../WebService.asmx/GetCourseTaughtDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            coursesRecords = result;
                            displayCoursesRecords();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading courses records:', error);
                }
            });

        }

        function loadPublishedCourses() {
            $.ajax({
                url: '../../WebService.asmx/GetPublishedCourses',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success && result.publishedCourses) {
                            publishedCourses = result.publishedCourses;
                            displayCoursesRecords(); // Refresh display to show correct button states
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading published courses:', error);
                }
            });
        }

        function navigateToPreviousMenu() {
            // Navigate to previous page (Area of Expertise)
            window.location.href = 'AreaofExpertise.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page (if any)
            showTopRightMessage('Courses details completed!');
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

