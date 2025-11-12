<%@ Page Title="SocialLink Details" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="SocialLink.aspx.cs" Inherits="Admin_Profile_SocialLink" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
      <div class="tab-content">
            <div class="tab-pane fade show active" id="social-links-tab" role="tabpanel">
                <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                        <i class="fas fa-share-alt me-2" style="font-size: 1rem;"></i>
                        Social Links
                    </h5>
                </div>

                <form id="socialLinksForm" class="personal-details-form">
                    <!-- Add New Social Link Section -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                                Add New Social Link
                            </h5>
            </div>
                        <div class="card-body">
                            <div class="row g-3">
              <div class="col-md-6">
                                    <label class="form-label required">Platform</label>
                                    <select id="platform" name="platform" class="form-select" required>
                                        <option value="" selected disabled>Select Social Platform</option>
                                        <option value="LINKEDIN">LinkedIn</option>
                                        <option value="TWITTER">Twitter</option>
                                        <option value="FACEBOOK">Facebook</option>
                                        <option value="INSTAGRAM">Instagram</option>
                                        <option value="GITHUB">GitHub</option>
                                        <option value="YOUTUBE">YouTube</option>
                                        <option value="WEBSITE">Personal Website</option>
                                        <option value="PORTFOLIO">Portfolio</option>
                                        <option value="BEHANCE">Behance</option>
                                        <option value="DRIBBBLE">Dribbble</option>
                                        <option value="STACKOVERFLOW">Stack Overflow</option>
                                        <option value="MEDIUM">Medium</option>
                                        <option value="OTHER">Other</option>
                </select>
              </div>
              <div class="col-md-6">
                                    <label class="form-label">Custom Platform Name</label>
                                    <input type="text" id="customPlatform" name="customPlatform" class="form-control" placeholder="Enter custom platform name" style="display: none;">
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label required">URL</label>
                                    <input type="url" id="url" name="url" class="form-control" placeholder="https://example.com/your-profile" required>
                                    <div class="form-text">Enter the complete URL including https://</div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Display Name</label>
                                    <input type="text" id="displayName" name="displayName" class="form-control" placeholder="Enter display name (optional)">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Description</label>
                                    <input type="text" id="description" name="description" class="form-control" placeholder="Brief description (optional)">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Visibility</label>
                                    <select id="visibility" name="visibility" class="form-select">
                                        <option value="PUBLIC">Public</option>
                                        <option value="PRIVATE">Private</option>
                                        <option value="PROFESSIONAL">Professional Only</option>
                                    </select>
              </div>
              <div class="col-md-6">
                                    <label class="form-label">Priority</label>
                                    <select id="priority" name="priority" class="form-select">
                                        <option value="HIGH">High</option>
                                        <option value="MEDIUM" selected>Medium</option>
                                        <option value="LOW">Low</option>
                                    </select>
              </div>
                                <div class="col-md-12">
                                    <button type="button" id="btnAddSocialLink" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus me-2"></i>
                                        Add Social Link
                                    </button>
                                    <button type="button" id="btnUpdateSocialLink" class="btn btn-warning btn-sm" style="display: none;">
                                        <i class="fas fa-edit me-2"></i>
                                        Update Social Link
                                    </button>
                                    <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                        <i class="fas fa-times me-2"></i>
                                        Cancel
                                    </button>
              </div>
            </div>
          </div>
        </div>

                    <!-- Social Links List -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                                Social Links Records
                            </h5>
      </div>
                        <div class="card-body">
                            <div id="socialLinksList">
                                <!-- Social links will be dynamically added here -->
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-share-alt fa-2x mb-3"></i>
                                    <p>No social links added yet. Add your first social link above.</p>
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

        .form-text {
            font-size: 11px;
            color: #6c757d;
            margin-top: 4px;
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

        .social-link-record {
            border: 1px solid #e9ecef;
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 12px;
            background: #fff;
            transition: all 0.2s ease;
        }

        .social-link-record:hover {
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            border-color: #007bff;
        }

        .social-link-record-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 10px;
        }

        .social-link-record-title {
            font-weight: 600;
            color: #495057;
            font-size: 14px;
            margin: 0;
        }

        .social-link-record-actions {
            display: flex;
            gap: 8px;
        }

        .social-link-record-details {
            font-size: 12px;
            color: #6c757d;
            line-height: 1.4;
        }

        .social-link-record-details .detail-item {
            margin-bottom: 4px;
        }

        .social-link-record-details .detail-label {
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

        .platform-icon {
            width: 20px;
            height: 20px;
            margin-right: 8px;
            border-radius: 3px;
        }

        .platform-badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 500;
            text-transform: uppercase;
        }

        .platform-badge.linkedin { background-color: #0077b5; color: white; }
        .platform-badge.twitter { background-color: #1da1f2; color: white; }
        .platform-badge.facebook { background-color: #4267b2; color: white; }
        .platform-badge.instagram { background-color: #e4405f; color: white; }
        .platform-badge.github { background-color: #333; color: white; }
        .platform-badge.youtube { background-color: #ff0000; color: white; }
        .platform-badge.website { background-color: #6c757d; color: white; }
        .platform-badge.portfolio { background-color: #17a2b8; color: white; }
        .platform-badge.behance { background-color: #1769ff; color: white; }
        .platform-badge.dribbble { background-color: #ea4c89; color: white; }
        .platform-badge.stackoverflow { background-color: #f48024; color: white; }
        .platform-badge.medium { background-color: #00ab6c; color: white; }
        .platform-badge.other { background-color: #6c757d; color: white; }

        .url-link {
            color: #007bff;
            text-decoration: none;
            font-size: 12px;
            word-break: break-all;
        }

        .url-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .visibility-badge {
            font-size: 10px;
            padding: 2px 6px;
            border-radius: 3px;
        }

        .visibility-badge.public { background-color: #d4edda; color: #155724; }
        .visibility-badge.private { background-color: #f8d7da; color: #721c24; }
        .visibility-badge.professional { background-color: #d1ecf1; color: #0c5460; }

        .priority-badge {
            font-size: 10px;
            padding: 2px 6px;
            border-radius: 3px;
        }

        .priority-badge.high { background-color: #f8d7da; color: #721c24; }
        .priority-badge.medium { background-color: #fff3cd; color: #856404; }
        .priority-badge.low { background-color: #d4edda; color: #155724; }

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
        var socialLinks = [];
        var editingIndex = -1;

        $(document).ready(function () {
            // Form validation
            $('#socialLinksForm').on('submit', function (e) {
                e.preventDefault();
                validateForm();
            });

            // Save button click handler
            $('#btnSave').click(function () {
                saveAllSocialLinks();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Add social link button click handler
            $('#btnAddSocialLink').click(function () {
                addSocialLink();
            });

            // Update social link button click handler
            $('#btnUpdateSocialLink').click(function () {
                updateSocialLink();
            });

            // Cancel edit button click handler
            $('#btnCancelEdit').click(function () {
                cancelEdit();
            });

            // Platform change handler
            $('#platform').change(function () {
                handlePlatformChange();
            });

            // URL validation
            $('#url').on('blur', function () {
                validateUrl();
            });

            // Load existing social links
            loadSocialLinks();
        });

        function handlePlatformChange() {
            var platform = $('#platform').val();
            var customPlatformField = $('#customPlatform');
            
            if (platform === 'OTHER') {
                customPlatformField.show().prop('required', true);
            } else {
                customPlatformField.hide().prop('required', false).val('');
            }
        }

        function validateForm() {
            var isValid = true;
            var requiredFields = ['platform', 'url'];

            requiredFields.forEach(function (fieldId) {
                var field = $('#' + fieldId);
                if (!field.val() || field.val().trim() === '') {
                    field.addClass('is-invalid');
                    isValid = false;
                } else {
                    field.removeClass('is-invalid');
                }
            });

            // Validate custom platform if OTHER is selected
            if ($('#platform').val() === 'OTHER') {
                var customPlatform = $('#customPlatform');
                if (!customPlatform.val() || customPlatform.val().trim() === '') {
                    customPlatform.addClass('is-invalid');
                    isValid = false;
                } else {
                    customPlatform.removeClass('is-invalid');
                }
            }

            // Validate URL
            if (!validateUrl()) {
                isValid = false;
            }

            return isValid;
        }

        function validateUrl() {
            var url = $('#url').val();
            var isValid = true;

            if (url) {
                var urlPattern = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/;
                if (!urlPattern.test(url)) {
                    $('#url').addClass('is-invalid');
                    showErrorMessage('Please enter a valid URL');
                    isValid = false;
                } else {
                    $('#url').removeClass('is-invalid');
                }
            }

            return isValid;
        }

        function addSocialLink() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var platform = $('#platform').val();
            var displayPlatform = platform === 'OTHER' ? $('#customPlatform').val() : platform;

            var socialLinkData = {
                platform: platform,
                displayPlatform: displayPlatform,
                url: $('#url').val(),
                displayName: $('#displayName').val() || displayPlatform,
                description: $('#description').val(),
                visibility: $('#visibility').val(),
                priority: $('#priority').val(),
                id: Date.now() // Temporary ID for client-side management
            };

            socialLinks.push(socialLinkData);
            displaySocialLinks();
            clearForm();
            
            showTopRightMessage('Social link added successfully!');
        }

        function updateSocialLink() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var platform = $('#platform').val();
            var displayPlatform = platform === 'OTHER' ? $('#customPlatform').val() : platform;

            var socialLinkData = {
                platform: platform,
                displayPlatform: displayPlatform,
                url: $('#url').val(),
                displayName: $('#displayName').val() || displayPlatform,
                description: $('#description').val(),
                visibility: $('#visibility').val(),
                priority: $('#priority').val(),
                id: socialLinks[editingIndex].id
            };

            socialLinks[editingIndex] = socialLinkData;
            displaySocialLinks();
            clearForm();
            cancelEdit();
            
            showTopRightMessage('Social link updated successfully!');
            
            // Call btnSaveAll click event after updating the record
            $('#btnSave').click();
        }

        function editSocialLink(index) {
            var record = socialLinks[index];
            
            // Fill form data
            $('#platform').val(record.platform);
            $('#url').val(record.url);
            $('#displayName').val(record.displayName);
            $('#description').val(record.description);
            $('#visibility').val(record.visibility);
            $('#priority').val(record.priority);
            
            // Handle custom platform
            if (record.platform === 'OTHER') {
                $('#customPlatform').val(record.displayPlatform).show().prop('required', true);
            } else {
                $('#customPlatform').hide().prop('required', false).val('');
            }
            
            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddSocialLink').hide();
            $('#btnUpdateSocialLink').show();
            $('#btnCancelEdit').show();
            
            // Highlight the form section
            var formCard = $('#platform').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');
            
            // Remove highlight after 3 seconds
            setTimeout(function() {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', '');
            }, 3000);

            // Scroll to form
            try {
                var platformField = document.getElementById('platform');
                if (platformField) {
                    platformField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } catch (e) {
                try {
                    $('html, body').animate({
                        scrollTop: $('#platform').offset().top - 100
                    }, 1000);
                } catch (e2) {
                    window.scrollTo(0, 0);
                }
            }
            
            showTopRightMessage('Social link loaded for editing!');
        }

        function deleteSocialLink(index) {
            if (confirm('Are you sure you want to delete this social link?')) {
                socialLinks.splice(index, 1);
                displaySocialLinks();
                showTopRightMessage('Social link deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddSocialLink').show();
            $('#btnUpdateSocialLink').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#platform').val('');
            $('#customPlatform').hide().prop('required', false).val('');
            $('#url').val('');
            $('#displayName').val('');
            $('#description').val('');
            $('#visibility').val('PUBLIC');
            $('#priority').val('MEDIUM');
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function displaySocialLinks() {
            var container = $('#socialLinksList');
            
            if (socialLinks.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-share-alt fa-2x mb-3"></i>
                        <p>No social links added yet. Add your first social link above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Platform</th>
                                <th style="font-size: 12px; font-weight: 600;">Display Name</th>
                                <th style="font-size: 12px; font-weight: 600;">URL</th>
                                <th style="font-size: 12px; font-weight: 600;">Description</th>
                                <th style="font-size: 12px; font-weight: 600;">Visibility</th>
                                <th style="font-size: 12px; font-weight: 600;">Priority</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            socialLinks.forEach(function(record, index) {
                var platformClass = record.platform.toLowerCase();
                var visibilityClass = record.visibility.toLowerCase();
                var priorityClass = record.priority.toLowerCase();
                
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">
                            <span class="platform-badge ${platformClass}">
                                <i class="fas fa-${getPlatformIcon(record.platform)} me-1"></i>
                                ${record.platform}
                            </span>
                        </td>
                        <td style="font-size: 12px; font-weight: 500;">${record.displayName}</td>
                        <td style="font-size: 12px;">
                            <a href="${record.url}" target="_blank" class="url-link" title="${record.url}">
                                <i class="fas fa-external-link-alt me-1"></i>
                                ${record.url.length > 30 ? record.url.substring(0, 30) + '...' : record.url}
                            </a>
                        </td>
                        <td style="font-size: 12px; max-width: 150px;">
                            <div class="text-truncate" title="${record.description || 'No description'}">
                                ${record.description || '-'}
            </div>
                        </td>
                        <td style="font-size: 12px;">
                            <span class="visibility-badge ${visibilityClass}">${record.visibility}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <span class="priority-badge ${priorityClass}">${record.priority}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editSocialLink(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteSocialLink(${index})" title="Delete Record">
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

        function getPlatformIcon(platform) {
            var icons = {
                'LINKEDIN': 'linkedin',
                'TWITTER': 'twitter',
                'FACEBOOK': 'facebook',
                'INSTAGRAM': 'instagram',
                'GITHUB': 'github',
                'YOUTUBE': 'youtube',
                'WEBSITE': 'globe',
                'PORTFOLIO': 'briefcase',
                'BEHANCE': 'behance',
                'DRIBBBLE': 'dribbble',
                'STACKOVERFLOW': 'stack-overflow',
                'MEDIUM': 'medium',
                'OTHER': 'link'
            };
            return icons[platform] || 'link';
        }

        function saveAllSocialLinks() {
            if (socialLinks.length === 0) {
                showErrorMessage('Please add at least one social link');
                return;
            }

            // Show loading state
            $('#btnSave').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-2"></span>Saving...');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/SaveSocialLinks",
                data: JSON.stringify({ formDataJson: JSON.stringify(socialLinks) }),
                dataType: "json",
                success: function (response) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');

                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'All social links saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save social links');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save social links');
                    }
                },
                error: function (xhr, status, error) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');
                    console.error('AJAX Error:', error);
                    showErrorMessage('An error occurred while saving social links');
                }
            });
        }

        function loadSocialLinks() {
            // Load existing social links from server
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetSocialLinks",
                data: "{}",
                dataType: "json",
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            socialLinks = result;
                            displaySocialLinks();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading social links:', error);
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
            // Navigate to previous page
            window.location.href = 'TrainingProgram.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page
            window.location.href = 'ExperienceDetails.aspx';
        }
    </script>
</asp:Content>
