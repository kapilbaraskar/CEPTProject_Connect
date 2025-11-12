<%@ Page Title="Upload Document" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="UploadDocument.aspx.cs" Inherits="Admin_Profile_UploadDocument" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .container-fluid {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
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

        .card-header {
            background-color: #f8f9fa;
            border-color: #dee2e6;
            padding: 12px 16px;
        }

        .card-body {
            padding: 16px;
            font-size: 13px;
        }

        .form-label {
            font-weight: 500;
            color: #2c3e50;
            margin-bottom: 5px;
            font-size: 12px;
        }

        .form-label.required::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }

        .form-control, .form-select {
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 6px 12px;
            font-size: 13px;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn {
            border-radius: 4px;
            font-weight: 500;
            padding: 6px 12px;
            transition: all 0.2s ease;
            border: 1px solid transparent;
            font-size: 12px;
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
        }

        .btn-outline-danger {
            border-color: #dc3545;
            color: #dc3545;
            background-color: transparent;
        }

        .btn-outline-danger:hover {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white;
            transform: translateY(-1px);
        }

        /* Document Upload Styles - Compact */
        .document-upload-container {
            border: 1px dashed #dee2e6;
            border-radius: 6px;
            padding: 12px;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
        }

        .document-upload-container:hover {
            border-color: #007bff;
            background-color: #f0f8ff;
        }

        .document-preview-area {
            text-align: center;
        }

        .document-upload-area {
            position: relative;
            display: inline-block;
            cursor: pointer;
            border-radius: 6px;
            overflow: hidden;
            transition: all 0.3s ease;
            width: 80px;
            height: 80px;
        }

        .document-upload-area:hover {
            transform: scale(1.02);
        }

        .document-icon {
            width: 80px;
            height: 80px;
            background-color: #f8f9fa;
            border: 1px dashed #dee2e6;
            border-radius: 6px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            transition: all 0.3s ease;
        }

        .document-icon i {
            font-size: 24px;
            margin-bottom: 4px;
        }

        .document-icon span {
            font-size: 10px;
            font-weight: 500;
        }

        .document-upload-area:hover .document-icon {
            background-color: #e9ecef;
            border-color: #007bff;
            color: #007bff;
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

        .document-upload-area:hover .upload-overlay {
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
            padding-left: 12px;
        }

        .upload-buttons {
            margin-top: 6px;
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
            align-items: center;
        }

        .upload-buttons .btn {
            min-width: 100px;
            margin-right: 0;
            padding: 4px 8px;
            font-size: 11px;
        }

        /* Identity Upload Styles - Compact */
        .identity-upload-container {
            border: 1px dashed #dee2e6;
            border-radius: 6px;
            padding: 8px;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
        }

        .identity-upload-container:hover {
            border-color: #007bff;
            background-color: #f0f8ff;
        }

        .identity-preview-area {
            text-align: center;
        }

        .identity-upload-area {
            position: relative;
            display: inline-block;
            cursor: pointer;
            border-radius: 6px;
            overflow: hidden;
            transition: all 0.3s ease;
            width: 60px;
            height: 60px;
        }

        .identity-upload-area:hover {
            transform: scale(1.02);
        }

        .identity-icon {
            width: 60px;
            height: 60px;
            background-color: #f8f9fa;
            border: 1px dashed #dee2e6;
            border-radius: 6px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            transition: all 0.3s ease;
        }

        .identity-icon i {
            font-size: 20px;
            margin-bottom: 2px;
        }

        .identity-icon span {
            font-size: 8px;
            font-weight: 500;
        }

        .identity-section {
            padding-left: 8px;
        }

        .identity-buttons {
            margin-top: 4px;
            display: flex;
            gap: 4px;
            flex-wrap: wrap;
            align-items: center;
        }

        .identity-buttons .btn {
            min-width: 80px;
            margin-right: 0;
            padding: 3px 6px;
            font-size: 10px;
        }

        .identity-buttons .btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Identity Type Badge Styles */
        .identity-type-badge {
            font-size: 10px;
            padding: 4px 8px;
            border-radius: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .identity-type-badge.pan {
            background-color: #e3f2fd;
            color: #1976d2;
            border: 1px solid #90caf9;
        }

        .identity-type-badge.aadhar {
            background-color: #f3e5f5;
            color: #7b1fa2;
            border: 1px solid #ce93d8;
        }

        .identity-type-badge.passport {
            background-color: #e8f5e8;
            color: #388e3c;
            border: 1px solid #a5d6a7;
        }

        .identity-type-badge.oci {
            background-color: #fff3e0;
            color: #f57c00;
            border: 1px solid #ffb74d;
        }

        .identity-type-badge.coa {
            background-color: #fce4ec;
            color: #c2185b;
            border: 1px solid #f48fb1;
        }

        /* Loading state for dropdown */
        .form-select.loading {
            background-image: url('data:image/svg+xml;charset=UTF-8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>');
            background-repeat: no-repeat;
            background-position: right 8px center;
            background-size: 16px 16px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            /*from { transform: rotate(0deg); }*/
            /*to { transform: rotate(360deg); }*/
        }

        .form-text {
            font-size: 11px;
            color: #6c757d;
            margin-top: 5px;
        }

        .file-info-display {
            margin-top: 10px;
            padding: 8px;
            background-color: #f8f9fa;
            border-radius: 4px;
            display: none;
        }

        .file-info-display.show {
            display: block;
        }

        .upload-status {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .upload-status.success {
            color: #28a745;
        }

        .upload-status.error {
            color: #dc3545;
        }

        .upload-status i {
            font-size: 14px;
            margin-right: 6px;
        }

        .uploaded-documents-list {
            max-height: 400px;
            overflow-y: auto;
        }

        .document-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            margin-bottom: 8px;
            background-color: #fff;
            transition: all 0.2s ease;
        }

        .document-item:hover {
            border-color: #007bff;
            box-shadow: 0 2px 4px rgba(0, 123, 255, 0.1);
        }

        .document-info {
            display: flex;
            align-items: center;
            flex: 1;
        }

        .document-icon-small {
            width: 40px;
            height: 40px;
            background-color: #f8f9fa;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            color: #6c757d;
        }

        .document-details {
            flex: 1;
        }

        .document-name {
            font-weight: 500;
            color: #2c3e50;
            font-size: 14px;
            margin-bottom: 2px;
        }

        .document-meta {
            font-size: 12px;
            color: #6c757d;
        }

        .document-actions {
            display: flex;
            gap: 8px;
        }

        .btn-document-action {
            padding: 4px 8px;
            font-size: 11px;
            border-radius: 4px;
        }

        .progress {
            height: 8px;
            background-color: #e9ecef;
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-bar {
            background-color: #007bff;
            transition: width 0.3s ease;
        }

        /* Table Styles */
        .table {
            font-size: 13px;
            margin-bottom: 0;
        }

        .table th {
            border-top: none;
            border-bottom: 2px solid #dee2e6;
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
            padding: 12px 8px;
        }

        .table td {
            border-top: 1px solid #dee2e6;
            padding: 12px 8px;
            vertical-align: middle;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 0, 0, 0.02);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }

        .document-type-badge {
            display: inline-block;
            padding: 4px 8px;
            font-size: 11px;
            font-weight: 500;
            border-radius: 4px;
            color: white;
        }

        .document-type-cv {
            background-color: #28a745;
        }

        .document-type-portfolio {
            background-color: #007bff;
        }

        .document-type-certificates {
            background-color: #ffc107;
            color: #212529;
        }

        .document-type-transcripts {
            background-color: #6f42c1;
        }

        .document-type-publications {
            background-color: #dc3545;
        }

        .document-type-other {
            background-color: #6c757d;
        }

        .file-name-cell {
            font-weight: 500;
            color: #2c3e50;
        }

        .file-size-cell {
            color: #6c757d;
            font-size: 12px;
        }

        .upload-date-cell {
            color: #6c757d;
            font-size: 12px;
        }

        .table-actions {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .btn-table-action {
            padding: 6px 12px;
            font-size: 11px;
            border-radius: 4px;
            min-width: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
        }

        .btn-table-action i {
            font-size: 11px;
        }


        .btn-view-document {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }

        .btn-view-document:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            color: white;
            transform: translateY(-1px);
        }

        .btn-delete-document {
            background-color: #dc3545;
            border-color: #dc3545;
            color: white;
        }

        .btn-delete-document:hover {
            background-color: #c82333;
            border-color: #bd2130;
            color: white;
            transform: translateY(-1px);
        }

        .btn-table-action:focus {
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-delete-document:focus {
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }

        .table-actions .btn {
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .btn-table-action:hover {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .document-upload-container {
                padding: 8px;
            }
            
            .document-upload-container .row {
                flex-direction: column;
            }
            
            .document-preview-area {
                margin-bottom: 10px;
            }
            
            .document-upload-area {
                width: 60px;
                height: 60px;
            }
            
            .document-icon {
                width: 60px;
                height: 60px;
            }
            
            .document-icon i {
                font-size: 18px;
            }
            
            .document-icon span {
                font-size: 8px;
            }
            
            .upload-section {
                padding-left: 0;
                margin-top: 8px;
            }
            
            .upload-buttons {
                justify-content: center;
            }
            
            .upload-buttons .btn {
                min-width: 80px;
                padding: 3px 6px;
                font-size: 10px;
            }
            
            .document-item {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .document-actions {
                margin-top: 8px;
                width: 100%;
                justify-content: flex-end;
            }
            
            .table-responsive {
                font-size: 12px;
            }
            
            .table th, .table td {
                padding: 8px 4px;
            }
            
            .document-type-badge {
                font-size: 10px;
                padding: 2px 4px;
            }
            
            .btn-table-action {
                padding: 4px 8px;
                font-size: 10px;
                min-width: 60px;
                gap: 2px;
            }
            
            .btn-table-action i {
                font-size: 10px;
            }
            
            .btn-table-action span {
                font-size: 10px;
            }
        }
    </style>
        <div class="container-fluid">
        <div class="form-header">
            <h1 class="form-title">Document Upload</h1>
            <p class="form-subtitle">Upload your professional documents including CV, Portfolio, Certificates, and more</p>
        </div>

        <form id="documentUploadForm">
            <!-- Hidden field for user ID -->
            <input type="hidden" id="user_id" name="user_id" value="" />
            
            <!-- User Identity Details Section -->
            <div class="card mb-3">
                <div class="card-header py-2">
                    <h6 class="mb-0" style="font-size: 0.9rem; color: black;">
                        <i class="fas fa-id-card me-2" style="font-size: 0.8rem;"></i>
                        User Identity Details
                    </h6>
                </div>
                <div class="card-body py-3">
                    <div class="row align-items-end">
                        <div class="col-md-3">
                            <label class="form-label required" style="font-size: 11px; margin-bottom: 4px;">Identity Type</label>
                            <select id="identityType" name="identityType" class="form-select form-select-sm">
                                <option value="" selected disabled>Loading Identity Types...</option>
                            </select>
                            </div>
                        <div class="col-md-3">
                            <label class="form-label required" style="font-size: 11px; margin-bottom: 4px;">Identity Number</label>
                            <input type="text" id="identityNumber" name="identityNumber" class="form-control form-control-sm" 
                                       placeholder="Enter identity number" maxlength="20">
                            </div>
                        <div class="col-md-6">
                            <label class="form-label" style="font-size: 11px; margin-bottom: 4px;">Upload Identity Document</label>
                            <div class="identity-buttons mb-2">
                                <button type="button" id="btnBrowseIdentity" class="btn btn-outline-primary btn-sm me-1" onclick="triggerIdentityInput()" disabled>
                                            <i class="fas fa-folder-open me-1"></i>
                                    Browse File
                                        </button>
                                        <button type="button" id="btnRemoveIdentity" class="btn btn-outline-danger btn-sm" onclick="removeIdentityFile()" style="display: none;">
                                            <i class="fas fa-trash me-1"></i>
                                            Remove
                                        </button>
                                    </div>
                            <div class="form-text" style="font-size: 10px; margin-bottom: 4px;">PDF, JPG, PNG (Max 5MB)</div>
                            <!-- Hidden file input -->
                            <input type="file" id="identityFile" name="identityFile" style="display: none;" accept=".pdf,.jpg,.jpeg,.png" onchange="previewIdentityFile(this)">
                            <div id="identityUploadProgress" class="mt-1" style="display: none;">
                                <div class="progress" style="height: 4px;">
                                    <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                                        </div>
                                <small class="text-muted" style="font-size: 10px;">Uploading...</small>
                                    </div>
                            <div id="identityFileInfo" class="file-info-display">
                                <div class="upload-status success">
                                    <i class="fas fa-check-circle"></i>
                                    <span class="file-name" id="identityFileName"></span>
                                            </div>
                                <div class="file-size" id="identityFileSize"></div>
                                    </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Identity Records List -->
            <div class="card mb-3" id="identityRecordsCard" style="display: none;">
                <div class="card-header py-2">
                    <h6 class="mb-0" style="font-size: 0.9rem; color: black;">
                        <i class="fas fa-list me-2" style="font-size: 0.8rem;"></i>
                        Identity Records
                    </h6>
                </div>
                <div class="card-body py-3">
                    <div class="table-responsive">
                        <table class="table table-sm table-hover" id="identityTable">
                            <thead>
                                <tr>
                                    <th style="font-size: 11px; font-weight: 600;">S.No</th>
                                    <th style="font-size: 11px; font-weight: 600;">Identity Type</th>
                                    <th style="font-size: 11px; font-weight: 600;">Identity Number</th>
                                    <th style="font-size: 11px; font-weight: 600;">Document File</th>
                                    <th style="font-size: 11px; font-weight: 600;">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="identityTableBody">
                                <!-- Identity records will be listed here -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Document Upload Section - Compact -->
            <div class="card mb-3">
                <div class="card-header py-2">
                    <h6 class="mb-0" style="font-size: 0.9rem; color: black;">
                        <i class="fas fa-file-upload me-2" style="font-size: 0.8rem;"></i>
                        Upload Reference Documents. (Ex. CV/Portfolio)
                    </h6>
                </div>
                <div class="card-body py-3">
                    <div class="row align-items-end">
                        <div class="col-md-3">
                            <label class="form-label required" style="font-size: 11px; margin-bottom: 4px;">Document Type</label>
                            <select id="documentType" name="documentType" class="form-select form-select-sm">
                                <option value="" selected disabled>Loading Document Types...</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label" style="font-size: 11px; margin-bottom: 4px;">Upload Document</label>
                            <div class="upload-buttons mb-2">
                                <button type="button" id="btnBrowseDocument" class="btn btn-outline-primary btn-sm me-1" onclick="triggerDocumentInput()">
                                                    <i class="fas fa-folder-open me-1"></i>
                                    Browse File
                                                </button>
                                                <button type="button" id="btnRemoveDocument" class="btn btn-outline-danger btn-sm" onclick="removeDocumentFile()" style="display: none;">
                                                    <i class="fas fa-trash me-1"></i>
                                    Remove
                                                </button>
                                            </div>
                            <div class="form-text" style="font-size: 10px; margin-bottom: 4px;">PDF, DOC, DOCX, TXT, JPG, PNG (Max 10MB)</div>
                            <!-- Hidden file input -->
                            <input type="file" id="documentFile" name="documentFile" style="display: none;" accept=".pdf,.doc,.docx,.txt,.jpg,.jpeg,.png" onchange="previewDocumentFile(this)">
                            <div id="documentUploadProgress" class="mt-1" style="display: none;">
                                <div class="progress" style="height: 4px;">
                                                    <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                                                </div>
                                <small class="text-muted" style="font-size: 10px;">Uploading...</small>
                                            </div>
                                            <div id="documentFileInfo" class="file-info-display">
                                                <div class="upload-status success">
                                                    <i class="fas fa-check-circle"></i>
                                                    <span class="file-name" id="documentFileName"></span>
                                                </div>
                                                <div class="file-size" id="documentFileSize"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Uploaded Documents List -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                        Uploaded Documents
                    </h5>
                </div>
                <div class="card-body">
                    <!-- Documents Table -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover" id="documentsTable">
                            <thead>
                                <tr>
                                    <th style="font-size: 12px; font-weight: 600; color: #495057;">Document Type</th>
                                    <th style="font-size: 12px; font-weight: 600; color: #495057;">File Name</th>
                                    <th style="font-size: 12px; font-weight: 600; color: #495057; display:none;">File Size</th>
                                    <th style="font-size: 12px; font-weight: 600; color: #495057;">Upload Date</th>
                                    <th style="font-size: 12px; font-weight: 600; color: #495057;">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="documentsTableBody">
                                <!-- Documents will be listed here -->
                                <tr id="noDocumentsRow">
                                    <td colspan="5" class="text-center text-muted py-4">
                                        <i class="fas fa-file-alt fa-3x mb-3"></i>
                                        <p style="font-size: 13px; margin: 0;">No documents uploaded yet. Upload your first document above.</p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    
                    <div id="uploadedDocumentsList" class="uploaded-documents-list" style="display: none;">
                        <!-- Documents will be listed here -->
                    </div>
                </div>
            </div>

            <!-- Navigation Buttons -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-navigation me-2" style="font-size: 0.85rem;"></i>
                        Navigation Buttons
                    </h5>
                </div>
                <div class="card-body" style="padding-top: 15px;">
                    <div class="d-flex justify-content-between align-items-center">
                        <button type="button" id="btnPrevious" class="btn btn-secondary btn-sm" onclick="goBack()">
                            <i class="fas fa-arrow-left me-2"></i>
                            Previous
                        </button>
                        <div class="action-buttons">
                            <button type="button" id="btnSave" class="btn btn-success btn-sm me-2">
                                <i class="fas fa-save me-2"></i>
                                Save Documents
                            </button>
                            <button type="button" id="btnNext" class="btn btn-primary btn-sm" onclick="goToNext()">
                                Next
                                <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <script>
        // Global variables
        var identityRecords = [];
        var uploadedIdentityFileName = '';
        var uploadedIdentityFilePath = '';
        $(document).ready(function () {
            
            loadDocumentTypes();
            loadIdentityTypes();
            loadExistingDocuments();
            $('#btnSave').click(function() {
                saveDocuments();
            });
            $('#identityType, #identityNumber').on('change keyup input', function() {
                validateIdentityFields();
            });

        });
        function triggerDocumentInput() {
            $('#documentFile').click();
        }

        function previewDocumentFile(input) {
            var file = input.files[0];
            if (file) {
                // Validate file type
                var allowedTypes = ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/plain', 'image/jpeg', 'image/jpg', 'image/png'];
                if (!allowedTypes.includes(file.type)) {
                    showErrorMessage('Please select a valid document type (PDF, DOC, DOCX, TXT, JPG, PNG)');
                    input.value = '';
                    return;
                }

                // Validate file size (10MB limit)
                if (file.size > 10 * 1024 * 1024) {
                    showErrorMessage('File size must be less than 10MB');
                    input.value = '';
                    return;
                }

                // Validate document type selection
                var documentType = $('#documentType').val();
                var documentTypeText = $('#documentType option:selected').text();
                if (!documentType) {
                    showErrorMessage('Please select a document type first');
                    input.value = '';
                    return;
                }
                 
                // Check if document type already exists
                if (isDocumentTypeExists(documentType)) {
                    showErrorMessage('A ' + documentTypeText + ' document already exists. Please delete the existing document first, then upload a new one.');
                    input.value = '';
                    return;
                }

                // Show file info
                $('#documentFileName').text(file.name);
                $('#documentFileSize').text('Size: ' + formatFileSize(file.size));
                $('#documentFileInfo').addClass('show');

                // Show remove button
                $('#btnRemoveDocument').show();
                setTimeout(function () {
                    uploadDocumentFile();
                }, 500);
            }
        }

        function uploadDocumentFile() {
            var file = $('#documentFile')[0].files[0];
            if (!file) return;
            var documentType = $('#documentType').val();
            var documentTypeText = $('#documentType option:selected').text();
            if (!documentType) {
                showErrorMessage('Please select a document type');
                return;
            }
            if (!documentTypeText) {
                showErrorMessage('Please select a document type');
                return;
            }
            // Double-check if document type already exists before uploading
            if (isDocumentTypeExists(documentType)) {
                showErrorMessage('A ' + documentTypeText + ' document already exists. Please delete the existing document first, then upload a new one.');
                clearDocumentForm();
                return;
            }
            var formData = new FormData();
            formData.append('file', file);
            formData.append('documentType', documentTypeText);
            formData.append('userId', getCurrentUserId());

            // Show progress
            $('#documentUploadProgress').show();
            $('#btnBrowseDocument').prop('disabled', true);

            $.ajax({
                url: '../../Handler/UserUploadFile.ashx',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total * 100;
                            $('#documentUploadProgress .progress-bar').css('width', percentComplete + '%');
                        }
                    }, false);
                    return xhr;
                },
                success: function (response) {
                    try {
                        var responsedata = JSON.parse(response);
                        if (responsedata && responsedata.error == '') {
                            showTopRightMessage('Document uploaded successfully: ' + file.name);

                            $('#documentFileName').text(responsedata.upfile);

                            // Update file info display with success status
                            $('#documentFileInfo .upload-status').removeClass('error').addClass('success');
                            $('#documentFileInfo .upload-status i').removeClass('fa-exclamation-circle').addClass('fa-check-circle');

                            // Add to uploaded documents list with file path
                            addDocumentToList(documentType, responsedata.upfile, file.size, documentTypeText, responsedata.upfilePath);

                            // Clear form for next upload
                            clearDocumentForm();

                        } else {
                            showErrorMessage('Document upload failed: ' + (responsedata.error || 'Unknown error'));
                            $('#documentFileInfo .upload-status').removeClass('success').addClass('error');
                            $('#documentFileInfo .upload-status i').removeClass('fa-check-circle').addClass('fa-exclamation-circle');
                        }
                    } catch (e) {
                        showErrorMessage('Error processing upload response');
                        console.error('Upload response error:', e);
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Document upload failed: ' + error);
                    $('#documentFileInfo .upload-status').removeClass('success').addClass('error');
                    $('#documentFileInfo .upload-status i').removeClass('fa-check-circle').addClass('fa-exclamation-circle');
                },
                complete: function () {
                    $('#documentUploadProgress').hide();
                    $('#btnBrowseDocument').prop('disabled', false);
                }
            });
        }

        function removeDocumentFile() {
            $('#documentFile').val('');
            $('#documentFileInfo').removeClass('show');
            $('#btnRemoveDocument').hide();
            $('#documentUploadProgress').hide();
            $('#btnBrowseDocument').prop('disabled', false);

            showTopRightMessage('Document removed successfully');
        }

        function clearDocumentForm() {
            $('#documentFile').val('');
            $('#documentFileInfo').removeClass('show');
            $('#btnRemoveDocument').hide();
            $('#documentUploadProgress').hide();
            $('#btnBrowseDocument').prop('disabled', false);
        }

        function getDocumentIcon(fileType) {
            if (fileType === 'application/pdf') {
                return { icon: 'fas fa-file-pdf', text: 'PDF Document' };
            } else if (fileType.includes('word')) {
                return { icon: 'fas fa-file-word', text: 'Word Document' };
            } else if (fileType === 'text/plain') {
                return { icon: 'fas fa-file-alt', text: 'Text Document' };
            } else if (fileType.startsWith('image/')) {
                return { icon: 'fas fa-file-image', text: 'Image Document' };
            } else {
                return { icon: 'fas fa-file', text: 'Document' };
            }
        }

        function addDocumentToList(type, filename, size, filenametext, filepath) {
            $('#noDocumentsRow').remove();
            
            var uploadDate = new Date().toLocaleDateString();
            var badgeClass = getDocumentTypeBadgeClass(filenametext);
            var iconClass = getDocumentIconByType(filenametext).icon;
            
            
            var actualFilepath = filepath || filename;
            var folderName = filenametext || type || '';
            var safeFolderForAttr = folderName.replace(/"/g, '&quot;');
            var safeFolderForJs = folderName.replace(/\\/g, '\\\\').replace(/'/g, "\\'");
            
            var tableRow = `
                <tr data-type="${type}" data-filename="${filename}" data-filepath="${actualFilepath}" data-documenttypename="${filenametext}" data-folder="${safeFolderForAttr}">
                    <td>
                        <span class="document-type-badge ${badgeClass}">
                            <i class="${iconClass} me-1"></i>${filenametext}
                        </span>
                    </td>
                    <td class="file-name-cell">${filename}</td>
                    <td class="file-size-cell" style="display:none;">${formatFileSize(size)}</td>
                    <td class="upload-date-cell">${uploadDate}</td>
                    <td>
                        <div class="table-actions">
                            <button type="button" class="btn btn-view-document btn-table-action" onclick="viewDocument('${filename}','${safeFolderForJs}')" title="View Document">
                                <i class="fas fa-eye"></i>
                                <span>View</span>
                            </button>
                            <button type="button" class="btn btn-download-document btn-table-action" onclick="downloadDocument('${filename}','${safeFolderForJs}')" title="Download Document">
                                <i class="fas fa-download"></i>
                                <span>Download</span>
                            </button>
                            <button type="button" class="btn btn-delete-document btn-table-action" onclick="removeDocumentFromTable('${filename}')" title="Delete Document">
                                <i class="fas fa-trash"></i>
                                <span>Delete</span>
                            </button>
                        </div>
                    </td>
                </tr>
            `;
            $('#documentsTableBody').append(tableRow);
            
            
            updateSaveButtonText();
        }

        function getDocumentIconByType(type) {
            switch (type) {
                case 'CV': return { icon: 'fas fa-file-alt', color: '#28a745' };
                case 'Portfolio': return { icon: 'fas fa-briefcase', color: '#007bff' };
                case 'Certificates': return { icon: 'fas fa-certificate', color: '#ffc107' };
                case 'Transcripts': return { icon: 'fas fa-graduation-cap', color: '#6f42c1' };
                case 'Publications': return { icon: 'fas fa-book', color: '#dc3545' };
                default: return { icon: 'fas fa-file', color: '#6c757d' };
            }
        }

        function getDocumentTypeBadgeClass(type) {
            switch (type) {
                case 'CV': return 'document-type-cv';
                case 'Portfolio': return 'document-type-portfolio';
                case 'Certificates': return 'document-type-certificates';
                case 'Transcripts': return 'document-type-transcripts';
                case 'Publications': return 'document-type-publications';
                default: return 'document-type-other';
            }
        }

        function fetchDownloadUrl(folderName, filename, onSuccess) {
            if (!filename) {
                showErrorMessage('Document file not found.');
                return;
            }

            $.ajax({
                url: '../../Handler/GetDocumentDownloadUrl.ashx',
                type: 'GET',
                data: {
                    folderName: folderName || '',
                    fileName: filename
                },
                dataType: 'json',
                success: function (response) {
                    if (response && response.success && response.downloadUrl) {
                        if (typeof onSuccess === 'function') {
                            onSuccess(response.downloadUrl);
                        }
                    } else {
                        var errorMessage = response && response.error ? response.error : 'Unable to generate download link.';
                        showErrorMessage(errorMessage);
                    }
                },
                error: function (xhr, status, error) {
                    var errorMessage = error || status || 'Unable to generate download link.';
                    showErrorMessage(errorMessage);
                }
            });
        }

        function triggerFileDownload(url, filename) {
            if (!url) {
                showErrorMessage('Download link is not available for this file.');
                return;
            }
            var link = document.createElement('a');
            link.href = url;
            if (filename) {
                link.download = filename;
            }
            link.style.display = 'none';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function viewDocument(filename, folderName) {
            if (!filename) {
                showErrorMessage('Document file not found.');
                return;
            }
            var resolvedFolder = folderName;
            if (!resolvedFolder) {
                var $row = $('#documentsTableBody tr[data-filename="' + filename + '"]').first();
                resolvedFolder = $row.data('folder') || $row.data('type') || '';
            }

            fetchDownloadUrl(resolvedFolder || '', filename, function (downloadUrl) {
                window.open(downloadUrl, '_blank');
            });
        }

        function downloadDocument(filename, folderName) {
            if (!filename) {
                showErrorMessage('Document file not found.');
                return;
            }
            var resolvedFolder = folderName;
            if (!resolvedFolder) {
                var $row = $('#documentsTableBody tr[data-filename="' + filename + '"]').first();
                resolvedFolder = $row.data('folder') || $row.data('type') || '';
            }

            fetchDownloadUrl(resolvedFolder || '', filename, function (downloadUrl) {
                triggerFileDownload(downloadUrl, filename);
            });
        }

        function removeDocumentFromTable(filename) {
            if (confirm('Are you sure you want to remove this document?')) {
                $('tr[data-filename="' + filename + '"]').remove();
                showTopRightMessage('Document removed from list');
                if ($('#documentsTableBody tr').length === 0) {
                    $('#documentsTableBody').html(`
                        <tr id="noDocumentsRow">
                            <td colspan="5" class="text-center text-muted py-4">
                                <i class="fas fa-file-alt fa-3x mb-3"></i>
                                <p style="font-size: 13px; margin: 0;">No documents uploaded yet. Upload your first document above.</p>
                            </td>
                        </tr>
                    `);
                }
                
                // Update save button text
                updateSaveButtonText();
            }
        }

        function removeDocumentFromList(filename) {
           
            removeDocumentFromTable(filename);
        }

        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            var k = 1024;
            var sizes = ['Bytes', 'KB', 'MB', 'GB'];
            var i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }

        function getCurrentUserId() {
            return $('#user_id').val() || 'current_user';
        }

        function isDocumentTypeExists(documentType) {
            // Check if document type already exists in the table
            var exists = false;
            $('#documentsTableBody tr').each(function() {
                var $row = $(this);
                var existingType = $row.data('type');
                if (existingType === documentType) {
                    exists = true;
                    return false; // Break out of loop
                }
            });
            return exists;
        }

        // Identity Functions
        function validateIdentityFields() {
            var identityType = $('#identityType').val();
            var identityNumber = $('#identityNumber').val().trim();
            
            if (identityType && identityNumber) {
                $('#btnBrowseIdentity').prop('disabled', false);
            } else {
                $('#btnBrowseIdentity').prop('disabled', true);
            }
        }

        function triggerIdentityInput() {
            var identityType = $('#identityType').val();
            var identityNumber = $('#identityNumber').val().trim();
            
            if (!identityType) {
                showErrorMessage('Please select an identity type first');
                return;
            }
            
            if (!identityNumber) {
                showErrorMessage('Please enter the identity number first');
                return;
            }
            
            $('#identityFile').click();
        }

        function previewIdentityFile(input) {
            var file = input.files[0];
            if (file) {
                // Validate file type
                var allowedTypes = ['application/pdf', 'image/jpeg', 'image/jpg', 'image/png'];
                if (!allowedTypes.includes(file.type)) {
                    showErrorMessage('Please select a valid file type (PDF, JPG, PNG)');
                    input.value = '';
                    return;
                }

                // Validate file size (5MB limit)
                if (file.size > 5 * 1024 * 1024) {
                    showErrorMessage('File size must be less than 5MB');
                    input.value = '';
                    return;
                }

                // Show file info
                $('#identityFileName').text(file.name);
                $('#identityFileSize').text('Size: ' + formatFileSize(file.size));
                $('#identityFileInfo').addClass('show');

                // Show remove button
                $('#btnRemoveIdentity').show();
                
                // Upload the file
                setTimeout(function () {
                    uploadIdentityFile();
                }, 500);
            }
        }

        function uploadIdentityFile() {
            var file = $('#identityFile')[0].files[0];
            if (!file) return;
            
            var formData = new FormData();
            formData.append('file', file);
            formData.append('documentType', 'Identity');
            formData.append('userId', getCurrentUserId());

            // Show progress
            $('#identityUploadProgress').show();
            $('#btnBrowseIdentity').prop('disabled', true);

            $.ajax({
                url: '../../Handler/UserUploadFile.ashx',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener("progress", function (evt) {
                        if (evt.lengthComputable) {
                            var percentComplete = evt.loaded / evt.total * 100;
                            $('#identityUploadProgress .progress-bar').css('width', percentComplete + '%');
                        }
                    }, false);
                    return xhr;
                },
                success: function (response) {
                    try {
                        var responsedata = JSON.parse(response);
                        if (responsedata && responsedata.error == '') {
                            showTopRightMessage('Identity document uploaded successfully: ' + file.name);
                            uploadedIdentityFileName = responsedata.upfile;
                            uploadedIdentityFilePath = responsedata.upfilePath;
                            autoAddIdentityRecord();
                        } else {
                            showErrorMessage('Identity document upload failed: ' + (responsedata.error || 'Unknown error'));
                        }
                    } catch (e) {
                        showErrorMessage('Error processing upload response');
                        console.error('Upload response error:', e);
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Identity document upload failed: ' + error);
                },
                complete: function () {
                    $('#identityUploadProgress').hide();
                    $('#btnBrowseIdentity').prop('disabled', false);
                }
            });
        }

        function removeIdentityFile() {
            $('#identityFile').val('');
            $('#identityFileInfo').removeClass('show');
            $('#btnRemoveIdentity').hide();
            $('#identityUploadProgress').hide();
            $('#btnBrowseIdentity').prop('disabled', false);
            uploadedIdentityFileName = '';
            uploadedIdentityFilePath = '';
            showTopRightMessage('Identity document removed successfully');
        }

        function getIdentityIcon(fileType) {
            if (fileType === 'application/pdf') {
                return { icon: 'fas fa-file-pdf', text: 'PDF' };
            } else if (fileType.startsWith('image/')) {
                return { icon: 'fas fa-file-image', text: 'IMG' };
            } else {
                return { icon: 'fas fa-id-card', text: 'DOC' };
            }
        }

        function autoAddIdentityRecord() {
            var identityType = $('#identityType').val();
            var identityTypeText = $('#identityType option:selected').text();
            var identityNumber = $('#identityNumber').val();

            // Validation
            if (!identityType) {
                showErrorMessage('Please select an identity type first');
                return;
            }

            if (!identityNumber.trim()) {
                showErrorMessage('Please enter the identity number first');
                return;
            }

            if (!uploadedIdentityFileName) {
                showErrorMessage('No identity document uploaded');
                return;
            }

            // Check if identity type already exists
            var exists = false;
            identityRecords.forEach(function(record) {
                if (record.identityType === identityType) {
                    exists = true;
                }
            });

            if (exists) {
                showErrorMessage('An identity record of type ' + identityTypeText + ' already exists. Please remove it first.');
                return;
            }

            // Add to records
            var record = {
                identityType: identityType,
                identityTypeText: identityTypeText,
                identityNumber: identityNumber,
                fileName: uploadedIdentityFileName,
                filePath: uploadedIdentityFilePath,
                uploadDate: new Date().toISOString()
            };

            identityRecords.push(record);
            addIdentityToTable(record, identityRecords.length);

            // Clear form
            clearIdentityForm();
            showTopRightMessage('Identity record added automatically');
        }

        function addIdentityRecord() {
            // Legacy function - now redirects to auto-add
            autoAddIdentityRecord();
        }

        function addIdentityToTable(record, index) {
            $('#identityRecordsCard').show();
            
            var badgeClass = getIdentityTypeBadgeClass(record.identityTypeText);
            var safeFilePathAttr = (record.filePath || '').replace(/"/g, '&quot;');
            
            var tableRow = `
                <tr data-type="${record.identityType}" data-filepath="${safeFilePathAttr}">
                    <td style="font-size: 11px;">${index}</td>
                    <td>
                        <span class="identity-type-badge ${badgeClass}">
                            ${record.identityTypeText}
                        </span>
                    </td>
                    <td style="font-size: 11px;">${record.identityNumber}</td>
                    <td style="font-size: 11px;">${record.fileName}</td>
                    <td>
                        <div class="table-actions">
                            <button type="button" class="btn btn-view-document btn-table-action" onclick="viewIdentityDocument('${record.fileName}','${record.identityType}')" title="View Document">
                                <i class="fas fa-eye"></i>
                                <span>View</span>
                            </button>
                            <button type="button" class="btn btn-download-document btn-table-action" onclick="downloadIdentityDocument('${record.fileName}')" title="Download Document">
                                <i class="fas fa-download"></i>
                                <span>Download</span>
                            </button>
                            <button type="button" class="btn btn-delete-document btn-table-action" onclick="removeIdentityRecord('${record.identityType}')" title="Delete Record">
                                <i class="fas fa-trash"></i>
                                <span>Delete</span>
                            </button>
                        </div>
                    </td>
                </tr>
            `;
            $('#identityTableBody').append(tableRow);
        }

        function getIdentityTypeBadgeClass(type) {
            switch (type.toLowerCase()) {
                case 'pan': return 'pan';
                case 'aadhar': return 'aadhar';
                case 'passport': return 'passport';
                case 'oci': return 'oci';
                case 'coa': return 'coa';
                default: return 'pan';
            }
        }

        function viewIdentityDocument(filename, foldername) {
            if (!filename) {
                showErrorMessage('Identity document not found.');
                return;
            }

            fetchDownloadUrl('Identity', filename, function (downloadUrl) {
                window.open(downloadUrl, '_blank');
            });
        }

        function downloadIdentityDocument(filename) {
            if (!filename) {
                showErrorMessage('Identity document not found.');
                return;
            }

            fetchDownloadUrl('Identity', filename, function (downloadUrl) {
                triggerFileDownload(downloadUrl, filename);
            });
        }

        function removeIdentityRecord(identityType) {
            if (confirm('Are you sure you want to remove this identity record?')) {
                // Remove from array
                identityRecords = identityRecords.filter(function(record) {
                    return record.identityType !== identityType;
                });

                // Remove from table
                $('tr[data-type="' + identityType + '"]').remove();

                // Hide table if no records
                if (identityRecords.length === 0) {
                    $('#identityRecordsCard').hide();
                }

                showTopRightMessage('Identity record removed successfully');
            }
        }

        function clearIdentityForm() {
            $('#identityType').val('');
            $('#identityNumber').val('');
            $('#identityFile').val('');
            $('#identityFileInfo').removeClass('show');
            $('#btnRemoveIdentity').hide();
            $('#identityUploadProgress').hide();
            $('#btnBrowseIdentity').prop('disabled', true);
            uploadedIdentityFileName = '';
            uploadedIdentityFilePath = '';
        }

    

        function loadDocumentTypes() {
            $('#documentType').addClass('loading');
            $.ajax({
                url: '../../WebService.asmx/GetDocumentMasterDtl',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            $('#documentType').empty();
                            $('#documentType').append('<option value="" selected disabled>Select Document Type</option>');
                            result.forEach(function (docType) {
                                $('#documentType').append('<option value="' + docType.ref_code + '">' + docType.ref_name + '</option>');
                            });
                        } else {
                            // Fallback to default options if service fails
                            loadDefaultDocumentTypes();
                        }
                    } catch (e) {
                        console.error('Error loading document types:', e);
                        loadDefaultDocumentTypes();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load document types:', error);
                    loadDefaultDocumentTypes();
                },
                complete: function() {
                    // Remove loading state
                    $('#documentType').removeClass('loading');
                }
            });
        }

        function loadDefaultDocumentTypes() {
            // Fallback default document types
            var defaultTypes = [
                { value: 'CV', text: 'CV / Resume' },
                { value: 'Portfolio', text: 'Portfolio' },
                { value: 'Certificates', text: 'Certificates' },
                { value: 'Transcripts', text: 'Academic Transcripts' },
                { value: 'Publications', text: 'Publications' },
                { value: 'Other', text: 'Other Documents' }
            ];
            
            $('#documentType').empty();
            $('#documentType').append('<option value="" selected disabled>Select Document Type</option>');
            
            defaultTypes.forEach(function(docType) {
                $('#documentType').append('<option value="' + docType.value + '">' + docType.text + '</option>');
            });
        }

        function loadIdentityTypes() {
            // Show loading state
            $('#identityType').addClass('loading');
            
            
            $.ajax({
                url: '../../WebService.asmx/GetIdentityMasterDtl',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        
                        // Check if result is a string that needs parsing
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            // Clear existing options
                            $('#identityType').empty();
                            $('#identityType').append('<option value="" selected disabled>Select Identity Type</option>');
                            
                            // Add dynamic options
                            result.forEach(function(identityType) {
                                $('#identityType').append('<option value="' + identityType.Identity_code + '">' + identityType.Identity_details + '</option>');
                            });
                        } else {
                            // Fallback to default options if service fails
                            loadDefaultIdentityTypes();
                        }
                    } catch (e) {
                        console.error('Error loading identity types:', e);
                        loadDefaultIdentityTypes();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load identity types:', error);
                    loadDefaultIdentityTypes();
                },
                complete: function() {
                    // Remove loading state
                    $('#identityType').removeClass('loading');
                }
            });
        }

        function loadDefaultIdentityTypes() {
            // Fallback default identity types
            var defaultTypes = [
                { value: 'PAN', text: 'PAN Card' },
                { value: 'Aadhar', text: 'Aadhar Card' },
                { value: 'Passport', text: 'Passport' },
                { value: 'OCI', text: 'OCI Card' },
                { value: 'COA', text: 'Certificate of Address' }
            ];
            
            $('#identityType').empty();
            $('#identityType').append('<option value="" selected disabled>Select Identity Type</option>');
            
            defaultTypes.forEach(function(identityType) {
                $('#identityType').append('<option value="' + identityType.value + '">' + identityType.text + '</option>');
            });
        }

        function loadExistingDocuments() {
            var userId = getCurrentUserId();
            
            $.ajax({
                url: '../../WebService.asmx/GetDocumentIdentityDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {

                        var doc = '';
                        var identities = '';
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (result.length > 0) {
                            doc = JSON.parse(result[0]);
                            identities = JSON.parse(result[1]);
                        }
                        if (doc.length > 0 && Array.isArray(doc)) {
                            loadDocumentsToTable(doc);
                        }
                        if (identities.length > 0 && Array.isArray(identities)) {
                            loadIdentitiesToTable(identities);
                        }
                        
                        // Update save button text
                        updateSaveButtonText();
                        
                    } catch (e) {
                        console.error('Error loading existing documents:', e);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load existing documents:', error);
                }
            });
        }

        function loadDocumentsToTable(documentsArray) {
            $('#documentsTableBody').empty();
            
            if (documentsArray.length > 0) {
                // Add each document to the table
                documentsArray.forEach(function(doc) {
                    addDocumentToList(
                        doc.ref_code,
                        doc.ref_file_name,
                        doc.fileSize || 0, 
                        doc.ref_name || doc.ref_name || doc.ref_name,
                        doc.ref_file_name || doc.ref_file_name
                    );
                });
            } else {
                // Show empty state
                $('#documentsTableBody').html(`
                    <tr id="noDocumentsRow">
                        <td colspan="5" class="text-center text-muted py-4">
                            <i class="fas fa-file-alt fa-3x mb-3"></i>
                            <p style="font-size: 13px; margin: 0;">No documents uploaded yet. Upload your first document above.</p>
                        </td>
                    </tr>
                `);
            }
        }

        function loadIdentitiesToTable(identitiesArray) {
            identityRecords = [];
            $('#identityTableBody').empty();
            
            if (identitiesArray.length > 0) {
                $('#identityRecordsCard').show();
                identitiesArray.forEach(function(identity, index) {
                    var record = {
                        identityType: identity.Identity_code,
                        identityTypeText: identity.Identity_name || identity.Identity_name,
                        identityNumber: identity.Identity_number,
                        fileName: identity.Identity_document,
                        filePath: identity.identity_file_path,
                        uploadDate: identity.created_date
                    };
                    
                    identityRecords.push(record);
                    addIdentityToTable(record, index + 1);
                });
            } else {
                // Hide identity records card
                $('#identityRecordsCard').hide();
            }
        }

        function updateSaveButtonText() {
            var documentCount = $('#documentsTableBody tr').not('#noDocumentsRow').length;
            
            if (documentCount > 0) {
                $('#btnSave').html(`<i class="fas fa-save me-2"></i>Save Documents (${documentCount})`);
                $('#btnSave').attr('title', `Save ${documentCount} document(s) to database`);
            } else {
                $('#btnSave').html('<i class="fas fa-save me-2"></i>Save Documents');
                $('#btnSave').attr('title', 'Save documents to database');
            }
        }

        function saveDocuments() {
            var documents = [];
            var identities = [];
            
            // Collect document data
            $('#documentsTableBody tr').each(function() {
                var $row = $(this);
                var filename = $row.data('filename');
                var type = $row.data('type');
                var filepath = $row.data('filepath') || '';
                var documentTypeName = $row.data('documenttypename') || '';
                
                if (filename && type) {
                    documents.push({
                        filename: filename,
                        filePath: filepath,
                        documentType: type,
                        documentTypeName: documentTypeName,
                        uploadDate: new Date().toISOString()
                    });
                }
            });

            
            identityRecords.forEach(function(record) {
                identities.push({
                    identityType: record.identityType,
                    identityTypeText: record.identityTypeText,
                    identityNumber: record.identityNumber,
                    fileName: record.fileName,
                    filePath: record.filePath,
                    uploadDate: record.uploadDate
                });
            });

            if (documents.length === 0 && identities.length === 0) {
                showErrorMessage('No documents or identity records to save. Please upload at least one document or add an identity record.');
                return;
            }
            
            $('#btnSave').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

           
            var combinedSaveData = {
                documents: documents,
                identities: identities,
                userId: getCurrentUserId(),
                action: 'save_all_data'
            };
            
            console.log('Saving Combined JSON:', JSON.stringify(combinedSaveData));
            $.ajax({
                url: '../../WebService.asmx/SaveDocumentDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ formDataJson: JSON.stringify(combinedSaveData) }),
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        result = JSON.parse(result);
                        if (result.success) {
                            var message = 'Data saved successfully!';
                            if (result.documentsSaved > 0) message += ' ' + result.documentsSaved + ' document(s)';
                            if (result.identitiesSaved > 0) message += ', ' + result.identitiesSaved + ' identity record(s)';
                            
                            showTopRightMessage(message);
                            console.log('All data saved successfully:', {
                                documents: result.documentsSaved || 0,
                                identities: result.identitiesSaved || 0
                            });
                        } else {
                            showErrorMessage('Failed to save data: ' + (result.error || 'Unknown error'));
                            console.error('Save failed:', result);
                        }
                    } catch (e) {
                        showErrorMessage('Error processing save response: ' + e.message);
                        console.error('Save response error:', e);
                    }
                },
                error: function(xhr, status, error) {
                    showErrorMessage('Failed to save data: ' + error);
                    console.error('Save error:', xhr.responseText);
                },
                complete: function() {
                    // Restore button state
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save Documents');
                }
            });
        }

        function getCurrentUserId() {
            // Try to get user ID from various sources
            var userId = $('#user_id').val() || 
                        $('#userId').val() || 
                        $('#UserID').val() || 
                        $('input[name="user_id"]').val() ||
                        $('input[name="userId"]').val() ||
                        $('input[name="UserID"]').val();
            
            if (!userId) {
                // Try to get from session or other sources
                userId = getUserIdFromSession();
            }
            
            return userId || 'current_user';
        }

        function getUserIdFromSession() {
            
            return null;
        }

        function goBack() {
            navigateToPreviousMenu();
        }

        function goToNext() {
            navigateToNextMenu();
        }

       
        </script>
    </asp:Content>