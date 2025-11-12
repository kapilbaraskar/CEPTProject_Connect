<%@ Page Title="Personal Details" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="PersonalDetails.aspx.cs" Inherits="Admin_Profile_PersonalDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
      <div class="tab-content">
            <div class="tab-pane fade show active" id="personal-details-tab" role="tabpanel">
                <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                        <i class="fas fa-user-circle me-2" style="font-size: 1rem;"></i>
                        Personal Details
                    </h5>
                </div>

        <form id="personalDetailsForm" class="personal-details-form">
            <!-- Profile Image Upload Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-image me-2" style="font-size: 0.85rem;"></i>
                        Profile Image Upload
                    </h5>
                </div>
                <div class="card-body">
                    <div class="profile-upload-container">
                        <div class="row align-items-center">
                            <div class="col-md-3">
                                <div class="profile-preview-area">
                                    <div class="image-upload-area" onclick="triggerFileInput()">
                                        <img id="profilePreview" src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='150' height='150' viewBox='0 0 150 150'%3E%3Crect width='150' height='150' fill='%23f8f9fa' stroke='%23dee2e6' stroke-width='2'/%3E%3Ctext x='75' y='70' text-anchor='middle' dy='.3em' fill='%236c757d' font-family='Arial, sans-serif' font-size='12'%3EProfile%3C/text%3E%3Ctext x='75' y='85' text-anchor='middle' dy='.3em' fill='%236c757d' font-family='Arial, sans-serif' font-size='12'%3EPreview%3C/text%3E%3C/svg%3E" 
                                             alt="Profile Preview" class="img-thumbnail">
                                        <div class="upload-overlay">
                                            <i class="fas fa-file-upload"></i>
                                            <span>Click to Upload</span>
                                        </div>
                                    </div>
                                    <!-- Hidden file input -->
                                    <input type="file" id="profileFile" name="profileFile" style="display: none;" accept=".jpg,.jpeg,.png" onchange="previewProfileFile(this)">
                                </div>
                            </div>
                            <div class="col-md-9">
                                <div class="upload-section">
                                    <div class="mb-3">
                                        <div class="form-text">Click on the preview area or use browse button to select and automatically upload profile image (JPG, JPEG, PNG - Max 5MB)</div>
                                    </div>
                                    <div class="upload-buttons">
                                        <button type="button" id="btnBrowseProfile" class="btn btn-outline-primary btn-sm me-2" onclick="triggerFileInput()">
                                            <i class="fas fa-folder-open me-1"></i>
                                            Browse File
                                        </button>
                                        <button type="button" id="btnRemoveProfile" class="btn btn-outline-danger btn-sm" onclick="removeProfileFile()" style="display: none;">
                                            <i class="fas fa-trash me-1"></i>
                                            Remove File
                                        </button>
                                    </div>
                                    <div id="profileUploadProgress" class="mt-2" style="display: none;">
                                        <div class="progress">
                                            <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                                        </div>
                                        <small class="text-muted">Uploading...</small>
                                    </div>
                                    <div id="profileFileInfo" class="file-info-display">
                                        <div class="upload-status success">
                                            <i class="fas fa-check-circle"></i>
                                            <span class="file-name" id="profileFileName"></span>
                                        </div>
                                        <div class="file-size" id="profileFileSize"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Basic Information Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-id-card me-2" style="font-size: 0.85rem;"></i>
                        Basic Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label required">First Name</label>
                        <input type="text" id="first_name" name="first_name" class="form-control" placeholder="Enter first name" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Middle Name</label>
                        <input type="text" id="middle_name" name="middle_name" class="form-control" placeholder="Enter middle name">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label required">Last Name</label>
                        <input type="text" id="last_name" name="last_name" class="form-control" placeholder="Enter last name" required>
            </div>
              <div class="col-md-6">
                        <label class="form-label required">Full Name</label>
                        <input type="text" id="full_name" name="full_name" class="form-control" placeholder="Enter full name" readonly>
              </div>
              <div class="col-md-3">
                        <label class="form-label required">Date of Birth</label>
                        <input type="date" id="dob" name="dob" class="form-control" required>
              </div>
              <div class="col-md-3">
                        <label class="form-label required">Gender</label>
                        <select id="gender" name="gender" class="form-select" required>
                            <option value="" selected disabled>Select Gender</option>
                            <option value="M">Male</option>
                            <option value="F">Female</option>
                            <option value="O">Other</option>
                </select>
              </div>
              </div>
            </div>

            <!-- Birth & Identity Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-map-marker-alt me-2" style="font-size: 0.85rem;"></i>
                        Birth & Identity Information - For Internal Purpose
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label required">Place of Birth</label>
                        <input type="text" id="place_of_birth" name="place_of_birth" class="form-control" placeholder="Enter place of birth" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label required">Nationality</label>
                       <%-- <input type="text" id="nationality" name="nationality" class="form-control" placeholder="Enter nationality" required>--%>

                         <select id="nationality" name="nationality" class="form-select" required>
                            <option value="" selected disabled>Select Nationality</option></select>
          </div>
                    <div class="col-md-6">
                        <label class="form-label required">Category</label>
                        <select id="category_id" name="category_id" class="form-select" required>
                            <option value="" selected disabled>Select Category</option>
                            <option value="General">General</option>
                            <option value="OBC">OBC</option>
                            <option value="SC">SC</option>
                            <option value="ST">ST</option>
                            <option value="EWS">EWS</option>
                        </select>
          </div>
        </div>
      </div>
            </div>

            <!-- Contact Information Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-phone me-2" style="font-size: 0.85rem;"></i>
                        Personal Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
              <div class="col-md-6">
                        <label class="form-label required">Mobile Number</label>
                        <input type="tel" id="mobile_no" name="mobile_no" class="form-control" placeholder="Enter mobile number" required>
              </div>
                    <div class="col-md-6">
                        <label class="form-label">Alternative Mobile Number</label>
                        <input type="tel" id="alternet_mob_no" name="alternet_mob_no" class="form-control" placeholder="Enter alternative mobile number">
              </div>
              <div class="col-md-6">
                        <label class="form-label required">Emergency Contact Name</label>
                        <input type="text" id="emergency_contact_name" name="emergency_contact_name" class="form-control" placeholder="Enter emergency contact name" required>
              </div>
              <div class="col-md-6">
                        <label class="form-label required">Emergency Contact Number</label>
                        <input type="tel" id="emergency_contact_no" name="emergency_contact_no" class="form-control" placeholder="Enter emergency contact number" required>
              </div>
                    </div>
              </div>
            </div>

            <!-- Email Information Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-envelope me-2" style="font-size: 0.85rem;"></i>
                        Email Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label required">Personal Email ID</label>
                        <input type="email" id="personal_email_id" name="personal_email_id" class="form-control" placeholder="Enter personal email" required>
          </div>
                    <div class="col-md-6">
                        <label class="form-label">Alternative Email ID</label>
                        <input type="email" id="alternet_email_id" name="alternet_email_id" class="form-control" placeholder="Enter alternative email">
          </div>
        </div>
                    </div>
      </div>
            </div>

            <!-- Profile Information Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-user-tie me-2" style="font-size: 0.85rem;"></i>
                        Profile Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
              <div class="col-md-6">
                        <label class="form-label">User Profile Details</label>
                        <textarea id="user_profile_dtl" name="user_profile_dtl" class="form-control" rows="3" placeholder="Enter profile details"></textarea>
              </div>
              <div class="col-md-6">
                        <label class="form-label">Education & Work Profile</label>
                        <textarea id="edu_work_profile" name="edu_work_profile" class="form-control" rows="3" placeholder="Enter education and work profile"></textarea>
              </div>
              </div>
              </div>
            </div>

            <!-- Office Location (Read-only) Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-building me-2" style="font-size: 0.85rem;"></i>
                        Office Details
                    </h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-sm align-middle mb-3" id="officeLocationTable">
                            <thead class="table-light">
                                <tr>
                                    <th style="width: 60px;">#</th>
                                    <th>Role</th>
                                    <th>Office Name</th>
                                    <th>Office Location</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="4" class="text-center text-muted">No office location details available.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                   <%-- <div class="d-flex justify-content-end">
                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="openOfficeLocationPage()">
                            <i class="fas fa-external-link-alt me-2"></i>
                            Manage Office Locations
                        </button>
                    </div>--%>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                    <button type="button" id="btnPrevious" class="btn btn-outline-secondary btn-sm" disabled>
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

        .form-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
        }

        .form-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 2rem;
        }

        .form-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            margin: 0;
        }

        .form-section {
            margin-bottom: 30px;
            background: #f8f9fa;
            border-radius: 10px;
            padding: 25px;
            border: 1px solid #e9ecef;
        }

        .section-header {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #dee2e6;
        }

        .section-title {
            color: #495057;
            font-weight: 600;
            font-size: 1.3rem;
            margin: 0;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 6px;
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

        .form-control[readonly] {
            background-color: #f8f9fa;
            border-color: #ced4da;
        }

        .form-actions {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 2px solid #e9ecef;
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
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            border-color: #28a745;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #1e7e34 0%, #155724 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-outline-secondary {
            border-color: #6c757d;
            color: #6c757d;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .personal-details-container {
                margin: 10px;
                padding: 15px;
            }

            .form-title {
                font-size: 1.5rem;
            }

            .form-section {
                padding: 20px 15px;
            }

            .action-buttons {
                flex-direction: column;
                width: 100%;
            }

            .action-buttons .btn {
                width: 100%;
                margin-bottom: 10px;
            }

            .form-actions .d-flex {
                flex-direction: column;
                gap: 20px;
            }
        }

        /* Animation for form sections */
        .form-section {
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Loading state for buttons */
        .btn.loading {
            position: relative;
            color: transparent;
        }

        .btn.loading::after {
            content: "";
            position: absolute;
            width: 16px;
            height: 16px;
            top: 50%;
            left: 50%;
            margin-left: -8px;
            margin-top: -8px;
            border: 2px solid transparent;
            border-top-color: #ffffff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Enhanced Profile Upload Styles */
        .profile-upload-container {
            border: 2px dashed #dee2e6;
            border-radius: 8px;
            padding: 20px;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
        }

        .profile-upload-container:hover {
            border-color: #007bff;
            background-color: #f0f8ff;
        }

        .profile-preview-area {
            text-align: center;
        }

        .image-upload-area {
            position: relative;
            display: inline-block;
            cursor: pointer;
            border-radius: 8px;
            overflow: hidden;
            transition: all 0.3s ease;
            width: 150px;
            height: 150px;
        }

        .image-upload-area:hover {
            transform: scale(1.02);
        }

        .profile-preview-area img {
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            display: block;
            width: 150px;
            height: 150px;
            object-fit: cover;
            object-position: center;
        }
        
        #profilePreview {
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            display: block;
            width: 150px;
            height: 150px;
            object-fit: cover;
            object-position: center;
        }

        .upload-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 123, 255, 0.8);
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            border-radius: 8px;
        }

        .image-upload-area:hover .upload-overlay {
            opacity: 1;
        }

        .upload-overlay i {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .upload-overlay span {
            font-size: 12px;
            font-weight: 500;
        }

        .upload-section {
            padding-left: 20px;
        }

        .upload-buttons {
            margin-top: 10px;
        }

        .upload-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            align-items: center;
        }

        .upload-buttons .btn {
            min-width: 120px;
            margin-right: 0;
        }

        .btn-outline-primary {
            border-color: #007bff;
            color: #007bff;
            background-color: transparent;
        }

        .btn-outline-primary:hover {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 123, 255, 0.3);
        }

        #profileUploadProgress {
            margin-top: 15px;
        }

        #profileUploadProgress .progress {
            height: 8px;
            border-radius: 4px;
            background-color: #e9ecef;
        }

        #profileUploadProgress .progress-bar {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border-radius: 4px;
            transition: width 0.3s ease;
        }

        /* Enhanced File Upload Styles */
        .file-info-display {
            padding: 8px 12px;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            border-radius: 4px;
            color: #155724;
            margin-top: 10px;
            display: none;
        }

        .file-info-display.show {
            display: block;
        }

        .file-info-display .file-name {
            font-weight: 500;
        }

        .file-info-display .file-size {
            font-size: 11px;
            opacity: 0.8;
        }

        .upload-status {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 10px;
        }

        .upload-status.success {
            color: #28a745;
        }

        .upload-status.error {
            color: #dc3545;
        }

        .upload-status i {
            font-size: 14px;
        }

        /* Enhanced button styles */
        .upload-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            align-items: center;
        }

        .upload-buttons .btn {
            min-width: 120px;
            margin-right: 0;
        }

        /* Drag and drop styles */
        .image-upload-area.drag-over {
            border: 2px dashed #007bff;
            background-color: rgba(0, 123, 255, 0.1);
        }

        .image-upload-area.drag-over .upload-overlay {
            opacity: 1;
            background: rgba(0, 123, 255, 0.9);
        }

        .form-text {
            font-size: 11px;
            color: #6c757d;
            margin-top: 5px;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .profile-upload-container {
                padding: 15px;
            }
            
            .profile-upload-container .row {
                flex-direction: column;
            }
            
            .profile-preview-area {
                margin-bottom: 20px;
            }
            
            .image-upload-area {
                width: 120px;
                height: 120px;
            }
            
            .profile-preview-area img {
                width: 120px;
                height: 120px;
            }
            
            .upload-section {
                padding-left: 0;
                margin-top: 15px;
            }
            
            .upload-buttons {
                justify-content: center;
            }
        }
    </style>
    <script>
         $(document).ready(function () {
             GetCountry();
             $('#first_name, #middle_name, #last_name').on('input', function () {
                 var firstName = $('#first_name').val().trim();
                 var middleName = $('#middle_name').val().trim();
                 var lastName = $('#last_name').val().trim();

                 var fullName = '';
                 if (firstName) fullName += firstName;
                 if (middleName) fullName += (fullName ? ' ' : '') + middleName;
                 if (lastName) fullName += (fullName ? ' ' : '') + lastName;

                 $('#full_name').val(fullName);
             });
             $('#personalDetailsForm').on('submit', function (e) {
                 e.preventDefault();
                 validateAndSave();
             });
             $('#btnSave').on('click', function () {
                 validateAndSave();
             });
             $('#btnPrevious').on('click', function () {
                 window.history.back();
             });
             $('input[required], select[required]').on('blur', function () {
                 validateField($(this));
             });
             loadPersonalDetails();
             loadOfficeLocations();
             
         });

         function validateField(field) {
             var value = field.val().trim();
             var isValid = true;
             var errorMessage = '';
             field.removeClass('is-valid is-invalid');

             if (field.prop('required') && !value) {
                 isValid = false;
                 errorMessage = 'This field is required';
             }
             else if (field.attr('type') === 'email' && value) {
                 var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                 if (!emailRegex.test(value)) {
                     isValid = false;
                     errorMessage = 'Please enter a valid email address';
                 }
             }
             else if (field.attr('type') === 'tel' && value) {
                 var phoneRegex = /^[\+]?[1-9][\d]{0,15}$/;
                 if (!phoneRegex.test(value.replace(/\s/g, ''))) {
                     isValid = false;
                     errorMessage = 'Please enter a valid phone number';
                 }
             }

             if (isValid) {
                 field.addClass('is-valid');
             } else {
                 field.addClass('is-invalid');
                 showFieldError(field, errorMessage);
             }

             return isValid;
         }

         function showFieldError(field, message) {
             field.siblings('.invalid-feedback').remove();
             field.after('<div class="invalid-feedback">' + message + '</div>');
         }

         function validateAndSave() {
             var isValid = true;
             var $form = $('#personalDetailsForm');
             $form.find('input[required], select[required]').each(function () {
                 if (!validateField($(this))) {
                     isValid = false;
                 }
             });

             if (isValid) {
                 savePersonalDetails();
             } else {
                 showErrorMessage('Please correct the errors before saving');
                 var firstInvalid = $form.find('.is-invalid').first();
                 if (firstInvalid.length) {
                     $('html, body').animate({
                         scrollTop: firstInvalid.offset().top - 100
                     }, 500);
                 }
             }
         }

         function savePersonalDetails() {
             var $saveBtn = $('#btnSave');
             var originalText = $saveBtn.html();
             $saveBtn.addClass('loading').prop('disabled', true);
             $saveBtn.html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');
             var formData = {
                 first_name: $('#first_name').val(),
                 middle_name: $('#middle_name').val(),
                 last_name: $('#last_name').val(),
                 full_name: $('#full_name').val(),
                 dob: $('#dob').val(),
                 place_of_birth: $('#place_of_birth').val(),
                 nationality: $('#nationality').val(),
                 gender: $('#gender').val(),
                 category_id: $('#category_id').val().trim(),
                 mobile_no: $('#mobile_no').val(),
                 alternet_mob_no: $('#alternet_mob_no').val(),
                 emergency_contact_name: $('#emergency_contact_name').val(),
                 emergency_contact_no: $('#emergency_contact_no').val(),
                 user_profile_dtl: $('#user_profile_dtl').val(),
                 edu_work_profile: $('#edu_work_profile').val(),
                 personal_email_id: $('#personal_email_id').val(),
                 alternet_email_id: $('#alternet_email_id').val(),
                 profile_file_name: window.uploadedProfileFileName || null,
                 profile_file_path: window.uploadedProfileFilePath || null
             };
             
             // Log the data being saved (including file information)
             console.log('Saving personal details with data:', formData);
             if (window.uploadedProfileFileName) {
                 console.log('File attached:', window.uploadedProfileFileName);
             }
             
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/SavePersonalDetails",
                 data: JSON.stringify({ formDataJson: JSON.stringify(formData) }),
                 dataType: "json",
                 success: function (response) {
                     $saveBtn.removeClass('loading').prop('disabled', false);
                     $saveBtn.html(originalText);

                     if (response && response.d) {
                         var result = response.d;
                         result = JSON.parse(result);

                         if (result.success) {
                             showSuccessMessage(result.message || 'Personal details saved successfully!');
                             // Enable Next button
                             $('#btnNext').prop('disabled', false);
                         }
                         else {
                             showErrorMessage(result.message || 'Failed to save personal details');
                             if (result.error) { console.error('Error details:', result.error); }
                         }
                     }
                     else {
                         showErrorMessage('Failed to save personal details');
                     }
                 },
                 error: function (xhr, status, error) {
                     $saveBtn.removeClass('loading').prop('disabled', false);
                     $saveBtn.html(originalText);
                     showErrorMessage('Error saving personal details: ' + error);
                 }
             });
         }

         function showSuccessMessage(message) {
             showTopRightMessage(message, 'success');
         }

         function showErrorMessage(message) {
             showPopup(message, 'danger');
         }

         function showTopRightMessage(message, type) {
             $('.top-right-message').remove();
             var messageHtml = '<div class="top-right-message alert alert-' + (type === 'success' ? 'success' : 'info') + ' alert-dismissible fade show" role="alert" style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">' +
                 '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'info-circle') + ' me-2"></i>' +
                 message +
                 '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>' +
                 '</div>';
             $('body').append(messageHtml);
             setTimeout(function () {
                 $('.top-right-message').alert('close');
             }, 3000);
             $('.top-right-message').on('closed.bs.alert', function () {
                 $(this).remove();
             });
         }

         function showPopup(message, type) {
             $('#messagePopup').remove();

             // Create popup modal
             var popupHtml = '<div id="messagePopup" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="messagePopupLabel" aria-hidden="true">' +
                 '<div class="modal-dialog modal-dialog-centered" role="document">' +
                 '<div class="modal-content">' +
                 '<div class="modal-header bg-' + (type === 'success' ? 'success' : 'danger') + ' text-white">' +
                 '<h5 class="modal-title" id="messagePopupLabel">' +
                 '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-triangle') + ' me-2"></i>' +
                 (type === 'success' ? 'Success' : 'Error') +
                 '</h5>' +
                 '<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>' +
                 '</div>' +
                 '<div class="modal-body text-center py-4">' +
                 '<p class="mb-0 fs-5">' + message + '</p>' +
                 '</div>' +
                 '<div class="modal-footer justify-content-center">' +
                 '<button type="button" class="btn btn-' + (type === 'success' ? 'success' : 'danger') + '" data-bs-dismiss="modal">OK</button>' +
                 '</div>' +
                 '</div>' +
                 '</div>' +
                 '</div>';

             // Add to body
             $('body').append(popupHtml);

             // Show popup
             $('#messagePopup').modal('show');

             // Auto-hide after 3 seconds for success, 5 seconds for error
             var hideDelay = type === 'success' ? 3000 : 5000;
             setTimeout(function () {
                 $('#messagePopup').modal('hide');
             }, hideDelay);

             // Remove popup from DOM after hiding
             $('#messagePopup').on('hidden.bs.modal', function () {
                 $(this).remove();
             });
         }

         function loadPersonalDetails() {

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/GetPersonalDetails",
                 data: '{}',
                 dataType: "json",
                 success: function (response) {
                     console.log('Personal details response:', response);
                     processPersonalDetailsResponse(response);
                 },
                 error: function (xhr, status, error) {
                     console.error('Error loading personal details:', error);
                 }
             });
         }

         function processPersonalDetailsResponse(response) {
             try {
                 if (response && response.d) {
                     var result = JSON.parse(response.d);
                     var data = result;
                     if (Array.isArray(data) && data.length > 0) {
                         data = data[0];
                     }
                     bindPersonalDetailsData(data);
                 }
                 else {
                     console.log('No data received from server');
                 }
             } catch (e) {
                 console.error('Error processing personal details response:', e);
             }
         }

         function formatDateForInput(dateString) {
             try {

                 var date;

                 if (typeof dateString === 'string') {
                     date = new Date(dateString);
                 } else if (dateString instanceof Date) {
                     date = dateString;
                 } else {
                     return '';
                 }
                 if (isNaN(date.getTime())) {
                     console.warn('Invalid date:', dateString);
                     return '';
                 }
                 var year = date.getFullYear();
                 var month = String(date.getMonth() + 1).padStart(2, '0');
                 var day = String(date.getDate()).padStart(2, '0');

                 return year + '-' + month + '-' + day;
             } catch (e) {
                 console.error('Error formatting date:', e);
                 return '';
             }
         }

         function bindDropdownValue(selector, value) {
             if (value) {
                 var $select = $(selector);
                 var $option = $select.find('option[value="' + value + '"]');

                 if ($option.length > 0) {
                     $select.val(value);
                     console.log('Set ' + selector + ' to:', value);
                 } else {
                     console.warn('Option not found for ' + selector + ':', value);
                     console.log('Available options:', $select.find('option').map(function () { return this.value; }).get());
                 }
             }
         }

         function loadOfficeLocations() {
             var $tbody = $('#officeLocationTable tbody');
             if ($tbody.length === 0) {
                 return;
             }

             $tbody.html('<tr><td colspan="4" class="text-center text-muted"><i class="fas fa-spinner fa-spin me-2"></i>Loading office location details...</td></tr>');

             $.ajax({
                 type: "POST",
                 url: "../../WebService.asmx/GetOfficeLocations",
                 contentType: "application/json; charset=utf-8",
                 data: "{}",
                 dataType: "json",
                 success: function (response) {
                     try {
                         var locations = [];
                         if (response && response.d) {
                             var parsed = JSON.parse(response.d);
                             if (Array.isArray(parsed)) {
                                 locations = parsed;
                             } else if (parsed && parsed.office_locations && Array.isArray(parsed.office_locations)) {
                                 locations = parsed.office_locations;
                             }
                         }
                         renderOfficeLocationTable(locations);
                     } catch (err) {
                         console.error('Error parsing office location data:', err);
                         renderOfficeLocationTable([]);
                     }
                 },
                 error: function (xhr, status, error) {
                     console.error('Error loading office location details:', error);
                     renderOfficeLocationTable([]);
                 }
             });
         }

         function renderOfficeLocationTable(locations) {
             var $tbody = $('#officeLocationTable tbody');
             if ($tbody.length === 0) {
                 return;
             }

             $tbody.empty();

             if (!Array.isArray(locations) || locations.length === 0) {
                 $tbody.append('<tr><td colspan="4" class="text-center text-muted">No office location details available.</td></tr>');
                 return;
             }

             locations.forEach(function (location, index) {
                 var publicService = location.PublicService || location.public_service || location.publicService || '';
                 var role = location.Role || location.role || location.office_role || location.OfficeRole || location.roll || location.Roll || '';
                 var officeLocation = location.OfficeLocation || location.office_location || location.officeLocation || '';

                 var rowHtml = '<tr>' +
                     '<td>' + (location.RowNo || index + 1) + '</td>' +
                     '<td>' + $('<div>').text(role || '-').html() + '</td>' +
                     '<td>' + $('<div>').text(publicService || '-').html() + '</td>' +
                     '<td>' + $('<div>').text(officeLocation || '-').html() + '</td>' +
                     '</tr>';

                 $tbody.append(rowHtml);
             });
         }

         function openOfficeLocationPage() {
             window.location.href = 'OfficeLocation.aspx';
         }

         function bindPersonalDetailsData(data) {
             console.log('Binding data:', data);

             // Basic Information
             if (data.first_name) $('#first_name').val(data.first_name);
             if (data.middle_name) $('#middle_name').val(data.middle_name);
             if (data.last_name) $('#last_name').val(data.last_name);
             if (data.Full_name) $('#full_name').val(data.Full_name);
             if (data.dob) {
                 // Format date for HTML date input (YYYY-MM-DD)
                 var dateValue = formatDateForInput(data.dob);
                 $('#dob').val(dateValue);
             }
             if (data.place_of_birth) $('#place_of_birth').val(data.place_of_birth);
             bindDropdownValue('#nationality', data.nationality);
             bindDropdownValue('#gender', data.gender);
             bindDropdownValue('#category_id', data.category_id);

             // Contact Information
             if (data.mobile_no) $('#mobile_no').val(data.mobile_no);
             if (data.alternet_mob_no) $('#alternet_mob_no').val(data.alternet_mob_no);
             if (data.emergency_contact_name) $('#emergency_contact_name').val(data.emergency_contact_name);
             if (data.emergency_contact_no) $('#emergency_contact_no').val(data.emergency_contact_no);

             // Email Information
             if (data.personal_email_id) $('#personal_email_id').val(data.personal_email_id);
             if (data.alternet_email_id) $('#alternet_email_id').val(data.alternet_email_id);

             // Profile Information
             if (data.user_profile_dtl) $('#user_profile_dtl').val(data.user_profile_dtl);
             if (data.edu_work_profile) $('#edu_work_profile').val(data.edu_work_profile);
            
            // Office Location table display (fallback if API delivers via personal details)
            //if (data && Array.isArray(data.office_locations) && data.office_locations.length > 0) {
            //    renderOfficeLocationTable(data.office_locations);
            //}
             
             // Handle profile image from database
             if (data.filename) {
                 console.log('Database filename found:', data.filename);
                 console.log('Database filepath:', data.filepath);
                 
                 $('#profileFileName').text(data.filename);
                 $('#profileFileInfo').addClass('show');
                 
                 // Store file information for save functionality
                 window.uploadedProfileFileName = data.filename;
                 window.uploadedProfileFilePath = data.filepath || data.filename;
                 
                 // Display the image if it's an image file
                 if (data.filepath) {
                     var fileExtension = data.filename.split('.').pop().toLowerCase();
                       if (['jpg', 'jpeg', 'png', 'gif'].includes(fileExtension)) {
                         var imageUrl = '..\\..\\UserUploadDocumnet\\Profile_Document\\' + data.filename;
                         var $profilePreview = $('#profilePreview');
                         console.log('profilePreview element count:', $profilePreview.length);
                         
                         if ($profilePreview.length > 0) {
                             $profilePreview.attr('src', imageUrl);
                             $profilePreview[0].src = imageUrl;
                             $profilePreview.trigger('load');
                         } else {
                             console.log('profilePreview element NOT found!');
                             console.log('Available elements with id containing "profile":', $('[id*="profile"]').map(function() { return this.id; }).get());
                         }
                         $profilePreview.off('error').on('error', function() {
                             var fileIcon = getFileIcon('image/' + fileExtension);
                             $(this).attr('src', fileIcon);
                         });
                         $profilePreview.off('load').on('load', function() {
                             console.log('Image loaded successfully!');
                             console.log('Image load event triggered');
                         });
                         
                     } else {
                         // It's a document, show appropriate icon
                         console.log('Document file, showing icon');
                         var fileIcon = getFileIcon('application/' + fileExtension);
                         $('#profilePreview').attr('src', fileIcon);
                     }
                 } else {
                     console.log('No filepath in database data');
                 }
                 
                 // Show remove button since file exists
                 $('#btnRemoveProfile').show();
                 
                 // Update save button text
                 updateSaveButtonText();
             } else {
                 console.log('No filename in database data');
             }

             console.log('Form data bound successfully');
         }

        function navigateToNextMenu() {
            console.log('Page loaded - calling AJAX method...');
            
            showLoadingIndicator();
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetMenuSequence",
                data: '{}',
                dataType: "json",
                success: function (response) {
                   // window.open('')
                    hideLoadingIndicator();
                    processPageLoadResponse(response);
                },
                 error: function (xhr, status, error) {
                    hideLoadingIndicator();
                    showErrorMessage('Failed to load page data');
                }
            });
        }

        function processPageLoadResponse(response) {
            try {
                 if (response && response.d) {
                    var data = response.d;
                    if (typeof data === 'string') {
                        data = JSON.parse(data);
                    }
                    if (data && data.length > 0) {
                        populateFormFields(data[0]);
                    }
                    console.log('Page data loaded successfully');
                }
                 else {
                    console.log('No data received from server');
                }
            } catch (e) {
                console.error('Error processing page load response:', e);
            }
        }

        function populateFormFields(data) {
            // Populate form fields with received data
            if (data.fullName) {
                $('input[placeholder="Enter full name"]').val(data.fullName);
            }
            if (data.dateOfBirth) {
                $('input[type="date"]').val(data.dateOfBirth);
            }
            if (data.gender) {
                 $('select.form-select option').each(function () {
                    if ($(this).text() === data.gender) {
                        $(this).prop('selected', true);
                    }
                });
            }
            if (data.email) {
                $('input[type="email"]').val(data.email);
            }
            if (data.mobileNumber) {
                $('input[placeholder="Enter mobile number"]').val(data.mobileNumber);
            }
            if (data.address) {
                $('textarea').val(data.address);
            }
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

        function showLoadingIndicator() {
            // Add loading overlay
            if ($('#pageLoadingOverlay').length === 0) {
                $('body').append(`
                    <div id="pageLoadingOverlay" style="
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background: rgba(255, 255, 255, 0.8);
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        z-index: 9999;
                    ">
                        <div class="text-center">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <div class="mt-2">Loading page data...</div>
                        </div>
                    </div>
                `);
            }
        }

        function hideLoadingIndicator() {
            $('#pageLoadingOverlay').remove();
        }

        function showErrorMessage(message) {
            // Show error message
            if ($('#errorMessage').length === 0) {
                $('body').append(`
                    <div id="errorMessage" class="alert alert-warning alert-dismissible fade show" style="
                        position: fixed;
                        top: 20px;
                        right: 20px;
                        z-index: 10000;
                        max-width: 300px;
                    ">
                        <strong>Warning!</strong> ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                `);
                
                // Auto-hide after 5 seconds
                 setTimeout(function () {
                    $('#errorMessage').alert('close');
                }, 5000);
            }
        }

        function GetCountry()
        {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_country_data",
                data: "{}",
                dataType: "json",
                success: function (response) {
                    try {
                        if (response && response.d) {
                            var countryData = JSON.parse(response.d);
                            bindCountryOptions(countryData);
                        } else {
                            console.log('No country data received from server');
                        }
                    } catch (e) {
                        console.error('Error processing country data:', e);
                        showErrorMessage('Error loading country data');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading country data:', error);
                    showErrorMessage('Error loading country data: ' + error);
                }
            });
        }

        function bindCountryOptions(countryData) {
            var $nationalitySelect = $('#nationality');
            
            // Clear existing options except the first one
            $nationalitySelect.find('option:not(:first)').remove();
            
            if (Array.isArray(countryData) && countryData.length > 0) {
                // Add country options
                $.each(countryData, function(index, country) {
                    var optionValue = country.country_id || country.id || country.CountryID;
                    var optionText = country.country_name || country.name || country.CountryName;
                    
                    if (optionValue && optionText) {
                        $nationalitySelect.append(
                            $('<option></option>')
                                .attr('value', optionValue)
                                .text(optionText)
                        );
                    }
                });
                
                console.log('Country options loaded successfully');
            } else {
                console.warn('Country data is not in expected format:', countryData);
            }
        }

        
        function triggerFileInput() {
            $('#profileFile').click();
        }

        function previewProfileFile(input) {
            if (input.files && input.files[0]) {
                var file = input.files[0];
                
                // Validate file size (5MB limit)
                if (file.size > 5 * 1024 * 1024) {
                    showErrorMessage('File size must be less than 5MB');
                    input.value = '';
                    return;
                }

                // Validate file type
                var allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];
                if (!allowedTypes.includes(file.type)) {
                    showErrorMessage('Please select a valid image file (JPG, JPEG, PNG only)');
                    input.value = '';
                    return;
                }

                // Show file info
                $('#profileFileName').text(file.name);
                $('#profileFileSize').text('Size: ' + formatFileSize(file.size));
                $('#profileFileInfo').addClass('show');
                
                // Show remove button
                $('#btnRemoveProfile').show();

                // Show image preview
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#profilePreview').attr('src', e.target.result);
                };
                reader.readAsDataURL(file);

                // Automatically start upload after preview
                setTimeout(function() {
                    uploadProfileFile();
                }, 500); // Small delay to show preview first
            }
        }

        function uploadProfileFile() {
            var fileInput = $('#profileFile')[0];
            if (!fileInput.files || !fileInput.files[0]) {
                showErrorMessage('Please select a file to upload');
                return;
            }

            var file = fileInput.files[0];

            // Show progress bar
            $('#profileUploadProgress').show();
            $('#profileUploadProgress .progress-bar').css('width', '0%');
            $('#profileUploadProgress small').text('Uploading...');

            // Disable browse button during upload
            $('#btnBrowseProfile').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i>Uploading...');

            // Create FormData for file upload
            var formData = new FormData();
            formData.append('file', file);
            formData.append('documentType', 'Profile_Document');
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
                            $('#profileUploadProgress .progress-bar').css('width', percentComplete + '%');
                            $('#profileUploadProgress small').text('Uploading... ' + Math.round(percentComplete) + '%');
                        }
                    }, false);
                    return xhr;
                },
                success: function(response) {
                    $('#profileUploadProgress').hide();
                    $('#btnBrowseProfile').prop('disabled', false).html('<i class="fas fa-folder-open me-1"></i>Browse File');
                    
                    var responsedata = JSON.parse(response);
                    if (responsedata && responsedata.error == '') {
                        // Upload successful
                        showTopRightMessage('File uploaded successfully: ' + file.name);
                        
                        $('#profileFileName').text(responsedata.upfile);
                        // Update file info display with success status
                        $('#profileFileInfo .upload-status').removeClass('error').addClass('success');
                        $('#profileFileInfo .upload-status i').removeClass('fa-exclamation-circle').addClass('fa-check-circle');
                        $('#profileFileInfo').addClass('show');
                        
                        // Store file information for later use
                        window.uploadedProfileFileName = responsedata.upfile;
                        window.uploadedProfileFilePath = responsedata.upfilePath;
                        
                        // Update save button text to show file is attached
                        updateSaveButtonText();
                        
                    } else
                    {
                        showErrorMessage('File upload failed: ' + (responsedata.error || 'Unknown error'));
                        $('#profileFileInfo .upload-status').removeClass('success').addClass('error');
                        $('#profileFileInfo .upload-status i').removeClass('fa-check-circle').addClass('fa-exclamation-circle');
                    }
                },
                error: function(xhr, status, error) {
                    $('#profileUploadProgress').hide();
                    $('#btnBrowseProfile').prop('disabled', false).html('<i class="fas fa-folder-open me-1"></i>Browse File');
                    showErrorMessage('File upload error: ' + error);
                    
                    // Update file info display with error status
                    $('#profileFileInfo .upload-status').removeClass('success').addClass('error');
                    $('#profileFileInfo .upload-status i').removeClass('fa-check-circle').addClass('fa-exclamation-circle');
                }
            });
        }

        function removeProfileFile() {
            if (confirm('Are you sure you want to remove the selected file?')) {
                // Reset file input
                $('#profileFile').val('');
                
                // Reset preview image
                $('#profilePreview').attr('src', 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'150\' height=\'150\' viewBox=\'0 0 150 150\'%3E%3Crect width=\'150\' height=\'150\' fill=\'%23f8f9fa\' stroke=\'%23dee2e6\' stroke-width=\'2\'/%3E%3Ctext x=\'75\' y=\'70\' text-anchor=\'middle\' dy=\'.3em\' fill=\'%236c757d\' font-family=\'Arial, sans-serif\' font-size=\'12\'%3EProfile%3C/text%3E%3Ctext x=\'75\' y=\'85\' text-anchor=\'middle\' dy=\'.3em\' fill=\'%236c757d\' font-family=\'Arial, sans-serif\' font-size=\'12\'%3EPreview%3C/text%3E%3C/svg%3E');
                
                // Hide upload elements
                $('#profileFileInfo').removeClass('show');
                $('#btnRemoveProfile').hide();
                $('#profileUploadProgress').hide();
                
                // Reset browse button
                $('#btnBrowseProfile').prop('disabled', false).html('<i class="fas fa-folder-open me-1"></i>Browse File');
                
                // Clear uploaded file information
                window.uploadedProfileFileName = null;
                window.uploadedProfileFilePath = null;
                
                // Update save button text to remove file indication
                updateSaveButtonText();
                
                showTopRightMessage('File removed successfully');
            }
        }

        function getFileIcon(fileType) {
            if (fileType === 'application/pdf' || fileType === 'pdf') {
                return 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'150\' height=\'150\' viewBox=\'0 0 150 150\'%3E%3Crect width=\'150\' height=\'150\' fill=\'%23dc3545\' stroke=\'%23dc3545\' stroke-width=\'2\'/%3E%3Ctext x=\'75\' y=\'75\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-family=\'Arial, sans-serif\' font-size=\'14\' font-weight=\'bold\'%3EPDF%3C/text%3E%3C/svg%3E';
            } else if (fileType.includes('word') || fileType === 'doc' || fileType === 'docx') {
                return 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'150\' height=\'150\' viewBox=\'0 0 150 150\'%3E%3Crect width=\'150\' height=\'150\' fill=\'%23007bff\' stroke=\'%23007bff\' stroke-width=\'2\'/%3E%3Ctext x=\'75\' y=\'75\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-family=\'Arial, sans-serif\' font-size=\'12\' font-weight=\'bold\'%3EDOC%3C/text%3E%3C/svg%3E';
            } else if (fileType.startsWith('image/') || ['jpg', 'jpeg', 'png', 'gif'].includes(fileType)) {
                return 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'150\' height=\'150\' viewBox=\'0 0 150 150\'%3E%3Crect width=\'150\' height=\'150\' fill=\'%2328a745\' stroke=\'%2328a745\' stroke-width=\'2\'/%3E%3Ctext x=\'75\' y=\'70\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-family=\'Arial, sans-serif\' font-size=\'12\' font-weight=\'bold\'%3EIMAGE%3C/text%3E%3Ctext x=\'75\' y=\'85\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-family=\'Arial, sans-serif\' font-size=\'10\'%3E' + fileType.toUpperCase() + '%3C/text%3E%3C/svg%3E';
            } else {
                return 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'150\' height=\'150\' viewBox=\'0 0 150 150\'%3E%3Crect width=\'150\' height=\'150\' fill=\'%236c757d\' stroke=\'%236c757d\' stroke-width=\'2\'/%3E%3Ctext x=\'75\' y=\'75\' text-anchor=\'middle\' dy=\'.3em\' fill=\'white\' font-family=\'Arial, sans-serif\' font-size=\'12\' font-weight=\'bold\'%3EFILE%3C/text%3E%3C/svg%3E';
            }
        }

        function getCurrentUserId() {
            return $('#user_id').val() || 'current_user'; // Placeholder
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

        // Enhanced File Upload Utility Functions
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }

        // Drag and Drop Functionality
        function initializeDragAndDrop() {
            const uploadArea = document.querySelector('.image-upload-area');
            
            ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                uploadArea.addEventListener(eventName, preventDefaults, false);
            });

            function preventDefaults(e) {
                e.preventDefault();
                e.stopPropagation();
            }

            ['dragenter', 'dragover'].forEach(eventName => {
                uploadArea.addEventListener(eventName, highlight, false);
            });

            ['dragleave', 'drop'].forEach(eventName => {
                uploadArea.addEventListener(eventName, unhighlight, false);
            });

            function highlight(e) {
                uploadArea.classList.add('drag-over');
            }

            function unhighlight(e) {
                uploadArea.classList.remove('drag-over');
            }

            uploadArea.addEventListener('drop', handleDrop, false);

            function handleDrop(e) {
                const dt = e.dataTransfer;
                const files = dt.files;

                if (files.length > 0) {
                    const fileInput = document.getElementById('profileFile');
                    fileInput.files = files;
                    previewProfileFile(fileInput);
                }
            }
        }

        // Function to update save button text based on file attachment
        function updateSaveButtonText() {
            var $saveBtn = $('#btnSave');
            var hasFile = window.uploadedProfileFileName && window.uploadedProfileFilePath;
            
            if (hasFile) {
                $saveBtn.html('<i class="fas fa-save me-2"></i>Save with File');
                $saveBtn.attr('title', 'Save personal details with attached file: ' + window.uploadedProfileFileName);
            } else {
                $saveBtn.html('<i class="fas fa-save me-2"></i>Save');
                $saveBtn.attr('title', 'Save personal details');
            }
        }

        // Initialize drag and drop when page loads
        $(document).ready(function() {
            initializeDragAndDrop();
            updateSaveButtonText(); // Initial update
        });
    </script>

</asp:Content>

