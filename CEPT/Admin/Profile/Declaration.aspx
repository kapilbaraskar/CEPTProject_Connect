<%@ Page Title="Declaration" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="Declaration.aspx.cs" Inherits="Admin_Profile_Declaration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Declaration
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="declaration-tab" role="tabpanel">
                <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6; padding-bottom:5px; display:none;">
                    <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                        <i class="fas fa-file-signature me-2" style="font-size: 1rem;"></i>
                        Declaration & Data Verification
                    </h5>
                </div>

                <form id="declarationForm" class="personal-details-form">
                    <!-- Data Verification Section -->
                    <div class="card mb-4" style="display:none;">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-check-circle me-2" style="font-size: 0.85rem;"></i>
                                Data Verification Summary
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <strong>Please review all your submitted information below and verify its accuracy.</strong>
                                    </div>
                                </div>
                                
                                <!-- Personal Information Summary -->
                                <div class="col-md-6" style="display:none;">
                                    <div class="summary-section">
                                        <h6 class="summary-title">
                                            <i class="fas fa-user me-2"></i>Personal Information
                                        </h6>
                                        <div class="summary-content">
                                            <div class="summary-item">
                                                <span class="label">Name:</span>
                                                <span class="value" id="summaryName">-</span>
                                            </div>
                                            <div class="summary-item">
                                                <span class="label">Email:</span>
                                                <span class="value" id="summaryEmail">-</span>
                                            </div>
                                            <div class="summary-item">
                                                <span class="label">Phone:</span>
                                                <span class="value" id="summaryPhone">-</span>
                                            </div>
                                            <div class="summary-item">
                                                <span class="label">Date of Birth:</span>
                                                <span class="value" id="summaryDOB">-</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Education Summary -->
                                <div class="col-md-6" style="display:none;">
                                    <div class="summary-section">
                                        <h6 class="summary-title">
                                            <i class="fas fa-graduation-cap me-2"></i>Education Details
                                        </h6>
                                        <div class="summary-content">
                                            <div class="summary-item">
                                                <span class="label">Highest Qualification:</span>
                                                <span class="value" id="summaryEducation">-</span>
                                            </div>
                                            <div class="summary-item" style="display:none;">
                                                <span class="label">Institution:</span>
                                                <span class="value" id="summaryInstitution">-</span>
                                            </div>
                                            <div class="summary-item" style="display:none;">
                                                <span class="label">Year of Passing:</span>
                                                <span class="value" id="summaryYear">-</span>
                                            </div>
                                            <div class="summary-item" style="display:none;">
                                                <span class="label">Percentage/CGPA:</span>
                                                <span class="value" id="summaryPercentage">-</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- CRDF Engagement Question -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-building me-2" style="font-size: 0.85rem;"></i>
                                CRDF Engagement
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="form-label" style="font-size: 1rem; font-weight: 600; color: #212529;">
                                        Do you have an ongoing or proposed engagement with the CEPT Research and Development Foundation (CRDF)?
                                    </label>
                                    <div class="mt-3">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="crdfEngagement" id="crdfYes" value="Yes">
                                            <label class="form-check-label" for="crdfYes" style="font-size: 0.9rem;">
                                                <i class="fas fa-check-circle me-1 text-success"></i>Yes
                                            </label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="crdfEngagement" id="crdfNo" value="No" checked>
                                            <label class="form-check-label" for="crdfNo" style="font-size: 0.9rem;">
                                                <i class="fas fa-times-circle me-1 text-danger"></i>No
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- CRDF Section -->
                    <div class="card mb-4" id="crdfFormSection" style="display: none;">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-building me-2" style="font-size: 0.85rem;"></i>
                                CRDF (Center for Research and Development Facilities)
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row" id="crdfFields">
                                <div class="col-md-6">
                                    <label class="form-label required">Engagement Name</label>
                                    <select id="engagement_name" name="engagement_name" class="form-select" required>
                                        <option value="" selected disabled>Select Engagement Name</option>
                                        <!-- Will be populated dynamically -->
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Name of Center</label>
                                    <input type="text" id="name_of_center" name="name_of_center" class="form-control" placeholder="Enter name of center" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Reporting To</label>
                                    <input type="text" id="reporting_to" name="reporting_to" class="form-control" placeholder="Enter reporting person/authority" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Engagement Nature</label>
                                    <select id="engagement_nature" name="engagement_nature" class="form-select" required>
                                        <option value="" selected disabled>Select Engagement Nature</option>
                                        <option value="Full-time">Full-time</option>
                                        <option value="Part-time">Part-time</option>
                                        <option value="Contractual">Contractual</option>
                                        <option value="Consultant">Consultant</option>
                                        <option value="Visiting">Visiting</option>
                                        <option value="Honorary">Honorary</option>
                                    </select>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label required">Engagement Details</label>
                                    <textarea id="engagement_details" name="engagement_details" class="form-control" rows="3" placeholder="Enter detailed information about the engagement" required maxlength="500"></textarea>
                                    <div class="text-end mt-1">
                                        <small class="text-muted">
                                            <span id="engagementCharCount">0</span> characters (Max: 500 characters)
                                        </small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label required">From Month</label>
                                    <select id="from_month" name="from_month" class="form-select" required>
                                        <option value="" selected disabled>Select Month</option>
                                        <option value="January">January</option>
                                        <option value="February">February</option>
                                        <option value="March">March</option>
                                        <option value="April">April</option>
                                        <option value="May">May</option>
                                        <option value="June">June</option>
                                        <option value="July">July</option>
                                        <option value="August">August</option>
                                        <option value="September">September</option>
                                        <option value="October">October</option>
                                        <option value="November">November</option>
                                        <option value="December">December</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label required">From Year</label>
                                    <select id="from_year" name="from_year" class="form-select" required>
                                        <option value="" selected disabled>Select Year</option>
                                        <option value="2015">2015</option>
                                        <option value="2016">2016</option>
                                        <option value="2017">2017</option>
                                        <option value="2018">2018</option>
                                        <option value="2019">2019</option>
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                        <option value="2023">2023</option>
                                        <option value="2024">2024</option>
                                        <option value="2025">2025</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label required">To Month</label>
                                    <select id="to_month" name="to_month" class="form-select" required>
                                        <option value="" selected disabled>Select Month</option>
                                        <option value="January">January</option>
                                        <option value="February">February</option>
                                        <option value="March">March</option>
                                        <option value="April">April</option>
                                        <option value="May">May</option>
                                        <option value="June">June</option>
                                        <option value="July">July</option>
                                        <option value="August">August</option>
                                        <option value="September">September</option>
                                        <option value="October">October</option>
                                        <option value="November">November</option>
                                        <option value="December">December</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label required">To Year</label>
                                    <select id="to_year" name="to_year" class="form-select" required>
                                        <option value="" selected disabled>Select Year</option>
                                        <option value="2015">2015</option>
                                        <option value="2016">2016</option>
                                        <option value="2017">2017</option>
                                        <option value="2018">2018</option>
                                        <option value="2019">2019</option>
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                        <option value="2023">2023</option>
                                        <option value="2024">2024</option>
                                        <option value="2025">2025</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Engagement Status</label>
                                    <select id="engagement_status" name="engagement_status" class="form-select" required>
                                        <option value="" selected disabled>Select Engagement Status</option>
                                        <option value="Active">Active</option>
                                        <option value="Completed">Completed</option>
                                        <option value="On Hold">On Hold</option>
                                        <option value="Terminated">Terminated</option>
                                    </select>
                                </div>
                                <div class="col-md-12" style="padding-top: 15px;">
                                    <button type="button" id="btnAddCRDF" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus me-2"></i>
                                        Add CRDF Record
                                    </button>
                                    <button type="button" id="btnUpdateCRDF" class="btn btn-warning btn-sm" style="display: none;">
                                        <i class="fas fa-edit me-2"></i>
                                        Update CRDF Record
                                    </button>
                                    <button type="button" id="btnCancelCRDFEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                        <i class="fas fa-times me-2"></i>
                                        Cancel
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- CRDF Records List -->
                    <div class="card mb-4" id="crdfRecordsSection" style="display: none;">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                                CRDF Records List
                            </h5>
                        </div>
                        <div class="card-body">
                            <div id="crdfRecordsList">
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-building fa-2x mb-3"></i>
                                    <p>No CRDF records added yet. Add your first record above.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Reference Section -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-users me-2" style="font-size: 0.85rem;"></i>
                                References
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <label class="form-label required">Name</label>
                                    <input type="text" id="reference_name" name="reference_name" class="form-control" placeholder="Enter reference name" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label required">Email ID</label>
                                    <input type="email" id="reference_email" name="reference_email" class="form-control" placeholder="Enter email address" required>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label required">Mobile Number</label>
                                    <input type="tel" id="reference_mobile" name="reference_mobile" class="form-control" placeholder="Enter mobile number" maxlength="10" required>
                                </div>
                                <div class="col-md-12" style="padding-top: 15px;">
                                    <button type="button" id="btnAddReference" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus me-2"></i>
                                        Add Reference
                                    </button>
                                    <button type="button" id="btnUpdateReference" class="btn btn-warning btn-sm" style="display: none;">
                                        <i class="fas fa-edit me-2"></i>
                                        Update Reference
                                    </button>
                                    <button type="button" id="btnCancelReferenceEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                        <i class="fas fa-times me-2"></i>
                                        Cancel
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- References List -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                                References List
                            </h5>
                        </div>
                        <div class="card-body">
                            <div id="referencesRecordsList">
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-users fa-2x mb-3"></i>
                                    <p>No references added yet. Add your first reference above.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Declaration Statements -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-file-contract me-2" style="font-size: 0.85rem;"></i>
                                Declaration Statements
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="declaration-statements">
                                <div class="declaration-item">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="declaration1" name="declaration1" required>
                                        <label class="form-check-label" for="declaration1">
                                            I hereby declare that all the information provided in this application is true, complete, and accurate to the best of my knowledge and belief.
                                        </label>
                                    </div>
                                </div>

                                <div class="declaration-item">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="declaration2" name="declaration2" required>
                                        <label class="form-check-label" for="declaration2">
                                            I understand that any false information or misrepresentation may result in the rejection of my application or termination of my candidacy.
                                        </label>
                                    </div>
                                </div>

                                <div class="declaration-item">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="declaration3" name="declaration3" required>
                                        <label class="form-check-label" for="declaration3">
                                            I have reviewed all the documents and information submitted and confirm their authenticity.
                                        </label>
                                    </div>
                                </div>

                                <div class="declaration-item">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="declaration4" name="declaration4" required>
                                        <label class="form-check-label" for="declaration4">
                                            I consent to the verification of the information provided by the concerned authorities.
                                        </label>
                                    </div>
                                </div>

                                <div class="declaration-item">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="declaration5" name="declaration5" required>
                                        <label class="form-check-label" for="declaration5">
                                            I understand that this declaration is legally binding and I am responsible for the accuracy of all information provided.
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Digital Signature Section -->
                    <div class="card mb-4">
                        <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                            <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                                <i class="fas fa-signature me-2" style="font-size: 0.85rem;"></i>
                                Digital Signature
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label required">Full Name (as signature)</label>
                                    <input type="text" id="signatureName" name="signatureName" class="form-control" placeholder="Enter your full name as digital signature" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label required">Date of Declaration</label>
                                    <input type="date" id="declarationDate" name="declarationDate" class="form-control" required>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Additional Comments (Optional)</label>
                                    <textarea id="additionalComments" name="additionalComments" class="form-control" rows="3" placeholder="Any additional comments or clarifications"></textarea>
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
                                <div class="action-buttons d-flex align-items-center">
                                    <button type="button" id="btnViewPersonalDetails" class="btn btn-info btn-sm me-3" onclick="navigateToPersonalDetailsView()">
                                        <i class="fas fa-user me-2"></i>
                                        View Personal Details
                                    </button>
                                    <button type="button" id="btnSaveDraft" class="btn btn-warning btn-sm me-3">
                                        <i class="fas fa-save me-2"></i>
                                        Save
                                    </button>
                                    <button type="button" id="btnSubmitDeclaration" class="btn btn-success btn-sm">
                                        <i class="fas fa-check-circle me-2"></i>
                                        Submit Declaration
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
        .summary-section {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .summary-title {
            color: #495057;
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
        }

        .summary-content {
            font-size: 0.85rem;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.25rem 0;
            border-bottom: 1px solid #e9ecef;
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .summary-item .label {
            font-weight: 500;
            color: #6c757d;
            min-width: 120px;
        }

        .summary-item .value {
            color: #495057;
            text-align: right;
            flex: 1;
        }

        .declaration-statements {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            padding: 1.5rem;
        }

        .declaration-item {
            margin-bottom: 1rem;
            padding: 0.75rem;
            background-color: white;
            border: 1px solid #e9ecef;
            border-radius: 0.375rem;
        }

        .declaration-item:last-child {
            margin-bottom: 0;
        }

        .declaration-item .form-check-label {
            font-size: 0.9rem;
            line-height: 1.4;
            color: #495057;
        }

        .declaration-item .form-check-input {
            margin-top: 0.2rem;
        }

        .required::after {
            content: " *";
            color: #dc3545;
        }

        .alert-info {
            background-color: #d1ecf1;
            border-color: #bee5eb;
            color: #0c5460;
        }

        .btn {
            font-size: 0.875rem;
            padding: 0.5rem 1rem;
        }

        .btn-sm {
            font-size: 0.8rem;
            padding: 0.375rem 0.75rem;
        }

        /* CRDF Section Styling */
        #crdfRecordsList .table {
            font-size: 13px;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        #crdfRecordsList .badge {
            font-size: 10px;
            padding: 4px 8px;
        }

        .form-label {
            font-size: 0.9rem;
            font-weight: 500;
            color: #495057;
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            font-size: 0.875rem;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        textarea.form-control {
            resize: vertical;
        }

        @media (max-width: 768px) {
            .summary-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .summary-item .value {
                text-align: left;
                margin-top: 0.25rem;
            }

            .action-buttons {
                flex-direction: column;
                gap: 0.5rem;
                width: 100%;
            }

            .action-buttons .btn {
                width: 100%;
            }
        }
    </style>

    <script>
        var crdfRecords = [];
        var editingCRDFIndex = -1;
        var referenceRecords = [];
        var editingReferenceIndex = -1;

        $(document).ready(function () {
            $('#declarationDate').val(new Date().toISOString().split('T')[0]);
            loadSummaryData();
            
            // CRDF engagement radio button handlers
            $('input[name="crdfEngagement"]').change(function () {
                toggleCRDFSection();
            });
            
            // CRDF button handlers
            $('#btnAddCRDF').click(function () {
                addCRDFRecord();
            });

            $('#btnUpdateCRDF').click(function () {
                updateCRDFRecord();
            });

            $('#btnCancelCRDFEdit').click(function () {
                cancelCRDFEdit();
            });

            // Character count for engagement details
            $('#engagement_details').on('input', function () {
                updateEngagementCharCount();
            });

            // Reference button handlers
            $('#btnAddReference').click(function () {
                addReferenceRecord();
            });

            $('#btnUpdateReference').click(function () {
                updateReferenceRecord();
            });

            $('#btnCancelReferenceEdit').click(function () {
                cancelReferenceEdit();
            });

            $('#btnSaveDraft').click(function () {
                saveDeclarationDraft();
            });

            $('#btnSubmitDeclaration').click(function () {
                submitDeclaration();
            });
            
            $('#declarationForm').on('submit', function (e) {
                e.preventDefault();
                if (validateForm()) {
                    submitDeclaration();
                }
            });

            // Load engagement names dynamically
            loadEngagementNames();
            // Load existing CRDF records
            loadCRDFRecords();
            // Load existing references
            loadReferenceRecords();
        });

        function loadSummaryData() {
            loadPersonalInfo();
            loadEducationDetails();
            loadDeclarationData();
        }

        function loadPersonalInfo() {
            $.ajax({
                url: '../../WebService.asmx/GetPersonalInfo',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ userId: getCurrentUserId() }),
                dataType: 'json',
                success: function (response) {
                    var result = response.d;
                    if (result) {
                        result = JSON.parse(result);
                        if (result.success && result.data) {
                            $('#summaryName').text(result.data.fullName || '-');
                            $('#summaryEmail').text(result.data.email || '-');
                            $('#summaryPhone').text(result.data.phone || '-');
                            $('#summaryDOB').text(result.data.dateOfBirth || '-');
                        }
                    }
                },
                error: function () {
                    $('#summaryName').text('-');
                    $('#summaryEmail').text('-');
                    $('#summaryPhone').text('-');
                    $('#summaryDOB').text('-');
                }
            });
        }

        function loadEducationDetails() {
            $.ajax({
                url: '../../WebService.asmx/GetEducationDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ userId: getCurrentUserId() }),
                dataType: 'json',
                success: function (response) {
                    var result = response.d;
                    if (result) {
                        result = JSON.parse(result);
                        if (result.success && result.data && result.data.length > 0) {
                            var latestEducation = result.data[0];
                            $('#summaryEducation').text(latestEducation.degree || '-');
                            $('#summaryInstitution').text(latestEducation.institution || '-');
                            $('#summaryYear').text(latestEducation.yearOfPassing || '-');
                            $('#summaryPercentage').text(latestEducation.percentage || '-');
                        }
                    }
                },
                error: function () {
                    $('#summaryEducation').text('-');
                    $('#summaryInstitution').text('-');
                    $('#summaryYear').text('-');
                    $('#summaryPercentage').text('-');
                }
            });
        }


        function loadDeclarationData() {
            $.ajax({
                url: '../../WebService.asmx/GetDeclarationData',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ userId: getCurrentUserId() }),
                dataType: 'json',
                success: function (response) {
                    var result = response.d;
                    if (result) {
                        result = JSON.parse(result);
                        if (result) {
                            var data = result;
                            
                            // Bind declaration checkboxes
                            if (data[0].declarations) {
                                var dec_data = JSON.parse(data[0].declarations);
                                if (declaration1) {
                                    $('#declaration1').prop('checked', true);
                                }
                                if (declaration2) {
                                    $('#declaration2').prop('checked', true);
                                }

                                if (declaration3) {
                                    $('#declaration3').prop('checked', true);
                                }

                                if (declaration4) {
                                    $('#declaration4').prop('checked', true);
                                }
                                if (declaration5) {
                                    $('#declaration5').prop('checked', true);
                                }
                            }
                            
                            // Bind signature and other fields
                            $('#signatureName').val(data[0].signatureName || '');
                            
                            $('#additionalComments').val(data[0].additionalcomments || '');
                            var dateValue = formatDateForInput(data[0].declarationdate);
                            $('#declarationDate').val(dateValue)
                            // If already submitted, disable form
                            if (data[0].status === 'Y') {
                                $('#declarationForm input, #declarationForm textarea, #declarationForm button').prop('disabled', true);
                                $('#btnSubmitDeclaration').text('Already Submitted');
                                $('#btnSubmitDeclaration').prop('disabled', true)
                                $('#btnSaveDraft').prop('disabled', true)
                                $('#declarationForm input, #declarationForm textarea, #declarationForm button').css('display', 'none');
                            }
                        }
                    }
                },
                error: function () {
                    // If no data found, keep form empty
                }
            });
        }

        // CRDF Functions
        function toggleCRDFSection() {
            var selectedValue = $('input[name="crdfEngagement"]:checked').val();
            
            if (selectedValue === 'Yes') {
                // Show CRDF form and records sections
                $('#crdfFormSection').slideDown(400);
                $('#crdfRecordsSection').slideDown(400);
                
                // Enable all CRDF fields
                $('#crdfFields input, #crdfFields select, #crdfFields textarea').prop('disabled', false);
                $('#btnAddCRDF, #btnUpdateCRDF, #btnCancelCRDFEdit').prop('disabled', false);
            } else {
                // Hide CRDF form and records sections
                $('#crdfFormSection').slideUp(400);
                $('#crdfRecordsSection').slideUp(400);
                
                // Disable all CRDF fields
                $('#crdfFields input, #crdfFields select, #crdfFields textarea').prop('disabled', true);
                $('#btnAddCRDF, #btnUpdateCRDF, #btnCancelCRDFEdit').prop('disabled', true);
                
                // Clear form and records if switching to No
                clearCRDFForm();
            }
        }

        function loadEngagementNames() {
            $.ajax({
                url: '../../WebService.asmx/GetEngagementMasterDtl',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            $('#engagement_name').find('option:not(:first)').remove();
                            $.each(result, function (index, item) {
                                var option = $('<option></option>')
                                    .attr('value', item.engagement_code || item.engagement_code)
                                    .text(item.engagement_name || item.engagement_name);
                                $('#engagement_name').append(option);
                            });
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading engagement names:', error);
                }
            });
        }

        function validateCRDFForm() {
            var isValid = true;
            var requiredFields = [
                'engagement_name', 'name_of_center', 'reporting_to', 
                'engagement_nature', 'engagement_details', 'from_month', 
                'from_year', 'to_month', 'to_year', 'engagement_status'
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

        function addCRDFRecord() {
            if (!validateCRDFForm()) {
                showErrorMessage('Please fill in all required CRDF fields');
                return;
            }

            var crdfData = {
                engagement_code: $('#engagement_name').val(),
                engagement_name_text: $('#engagement_name option:selected').text(),
                name_of_center: $('#name_of_center').val(),
                reporting_to: $('#reporting_to').val(),
                engagement_nature: $('#engagement_nature').val(),
                engagement_details: $('#engagement_details').val(),
                from_month: $('#from_month').val(),
                from_year: $('#from_year').val(),
                to_month: $('#to_month').val(),
                to_year: $('#to_year').val(),
                engagement_status: $('#engagement_status').val(),
                id: Date.now()
            };

            crdfRecords.push(crdfData);
            displayCRDFRecords();
            clearCRDFForm();
            showTopRightMessage('CRDF record added successfully!');
        }

        function updateCRDFRecord() {
            if (!validateCRDFForm()) {
                showErrorMessage('Please fill in all required CRDF fields');
                return;
            }

            var crdfData = {
                engagement_code: $('#engagement_name').val(),
                engagement_name_text: $('#engagement_name option:selected').text(),
                name_of_center: $('#name_of_center').val(),
                reporting_to: $('#reporting_to').val(),
                engagement_nature: $('#engagement_nature').val(),
                engagement_details: $('#engagement_details').val(),
                from_month: $('#from_month').val(),
                from_year: $('#from_year').val(),
                to_month: $('#to_month').val(),
                to_year: $('#to_year').val(),
                engagement_status: $('#engagement_status').val(),
                id: crdfRecords[editingCRDFIndex].id
            };

            crdfRecords[editingCRDFIndex] = crdfData;
            displayCRDFRecords();
            clearCRDFForm();
            cancelCRDFEdit();
            showTopRightMessage('CRDF record updated successfully!');
        }

        function editCRDFRecord(index) {
            var record = crdfRecords[index];
            
            // Fill form data
            $('#engagement_name').val(record.engagement_code);
            $('#name_of_center').val(record.name_of_center);
            $('#reporting_to').val(record.reporting_to);
            $('#engagement_nature').val(record.engagement_nature);
            $('#engagement_details').val(record.engagement_details);
            $('#from_month').val(record.from_month);
            $('#from_year').val(record.from_year);
            $('#to_month').val(record.to_month);
            $('#to_year').val(record.to_year);
            $('#engagement_status').val(record.engagement_status);
            
            // Update character count
            updateEngagementCharCount();
            
            // Show update buttons, hide add button
            editingCRDFIndex = index;
            $('#btnAddCRDF').hide();
            $('#btnUpdateCRDF').show();
            $('#btnCancelCRDFEdit').show();
            
            showTopRightMessage('CRDF record loaded for editing!');
        }

        function deleteCRDFRecord(index) {
            if (confirm('Are you sure you want to delete this CRDF record?')) {
                crdfRecords.splice(index, 1);
                displayCRDFRecords();
                showTopRightMessage('CRDF record deleted successfully!');
            }
        }

        function cancelCRDFEdit() {
            editingCRDFIndex = -1;
            $('#btnAddCRDF').show();
            $('#btnUpdateCRDF').hide();
            $('#btnCancelCRDFEdit').hide();
            clearCRDFForm();
        }

        function clearCRDFForm() {
            $('#engagement_name').val('');
            $('#name_of_center').val('');
            $('#reporting_to').val('');
            $('#engagement_nature').val('');
            $('#engagement_details').val('');
            $('#from_month').val('');
            $('#from_year').val('');
            $('#to_month').val('');
            $('#to_year').val('');
            $('#engagement_status').val('');
            
            // Reset character count
            updateEngagementCharCount();
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function updateEngagementCharCount() {
            var text = $('#engagement_details').val();
            var charCount = text.length;
            
            $('#engagementCharCount').text(charCount);
            
            // Change color based on character limit
            var charCountElement = $('#engagementCharCount');
            if (charCount > 450) {
                charCountElement.css('color', '#dc3545'); // Red for near limit
            } else if (charCount > 400) {
                charCountElement.css('color', '#ffc107'); // Yellow for warning
            } else {
                charCountElement.css('color', '#6c757d'); // Default muted color
            }
        }

        function displayCRDFRecords() {
            var container = $('#crdfRecordsList');
            
            if (crdfRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-building fa-2x mb-3"></i>
                        <p>No CRDF records added yet. Add your first record above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Engagement Name</th>
                                <th style="font-size: 12px; font-weight: 600;">Center Name</th>
                                <th style="font-size: 12px; font-weight: 600;">Reporting To</th>
                                <th style="font-size: 12px; font-weight: 600;">Nature</th>
                                <th style="font-size: 12px; font-weight: 600;">Details</th>
                                <th style="font-size: 12px; font-weight: 600;">Period</th>
                                <th style="font-size: 12px; font-weight: 600;">Status</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            crdfRecords.forEach(function (record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">
                            <span class="badge bg-primary">${record.engagement_name_text || record.engagement_code}</span>
                        </td>
                        <td style="font-size: 12px;">${record.name_of_center}</td>
                        <td style="font-size: 12px;">${record.reporting_to}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getEngagementNatureBadgeClass(record.engagement_nature)}">${record.engagement_nature}</span>
                        </td>
                        <td style="font-size: 12px;">${record.engagement_details ? (record.engagement_details.length > 40 ? record.engagement_details.substring(0, 40) + '...' : record.engagement_details) : '-'}</td>
                        <td style="font-size: 12px;">${record.from_month} ${record.from_year} - ${record.to_month} ${record.to_year}</td>
                        <td style="font-size: 12px;">
                            <span class="badge ${getEngagementStatusBadgeClass(record.engagement_status)}">${record.engagement_status}</span>
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editCRDFRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteCRDFRecord(${index})" title="Delete Record">
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

        function getEngagementNatureBadgeClass(nature) {
            switch (nature) {
                case 'Full-time': return 'bg-success';
                case 'Part-time': return 'bg-info';
                case 'Contractual': return 'bg-warning';
                case 'Consultant': return 'bg-primary';
                case 'Visiting': return 'bg-secondary';
                case 'Honorary': return 'bg-dark';
                default: return 'bg-secondary';
            }
        }

        function getEngagementStatusBadgeClass(status) {
            switch (status) {
                case 'Active': return 'bg-success';
                case 'Completed': return 'bg-primary';
                case 'On Hold': return 'bg-warning';
                case 'Terminated': return 'bg-danger';
                default: return 'bg-secondary';
            }
        }

        function loadCRDFRecords() {
            $.ajax({
                url: '../../WebService.asmx/GetCRDFDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            crdfRecords = result;
                            
                            // Set radio button to "Yes" since data exists
                            $('#crdfYes').prop('checked', true);
                            
                            // Show CRDF sections
                            $('#crdfFormSection').show();
                            $('#crdfRecordsSection').show();
                            
                            // Enable all CRDF fields
                            $('#crdfFields input, #crdfFields select, #crdfFields textarea').prop('disabled', false);
                            $('#btnAddCRDF, #btnUpdateCRDF, #btnCancelCRDFEdit').prop('disabled', false);
                            
                            // Display the records
                            displayCRDFRecords();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading CRDF records:', error);
                }
            });
        }

       
        // Reference Functions
        function validateReferenceForm() {
            var isValid = true;
            var requiredFields = ['reference_name', 'reference_email', 'reference_mobile'];

            requiredFields.forEach(function (fieldId) {
                var field = $('#' + fieldId);
                if (!field.val()) {
                    field.addClass('is-invalid');
                    isValid = false;
                } else {
                    field.removeClass('is-invalid');
                }
            });

            // Validate email format
            var email = $('#reference_email').val();
            if (email && !isValidEmail(email)) {
                $('#reference_email').addClass('is-invalid');
                isValid = false;
                showErrorMessage('Please enter a valid email address');
            }

            // Validate mobile number (10 digits)
            var mobile = $('#reference_mobile').val();
            if (mobile && !/^\d{10}$/.test(mobile)) {
                $('#reference_mobile').addClass('is-invalid');
                isValid = false;
                showErrorMessage('Please enter a valid 10-digit mobile number');
            }

            return isValid;
        }

        function isValidEmail(email) {
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailPattern.test(email);
        }

        function addReferenceRecord() {
            if (!validateReferenceForm()) {
                return;
            }

            var referenceData = {
                references_name: $('#reference_name').val(),
                references_email: $('#reference_email').val(),
                references_mobile: $('#reference_mobile').val(),
                id: Date.now()
            };

            referenceRecords.push(referenceData);
            displayReferenceRecords();
            clearReferenceForm();
            showTopRightMessage('Reference added successfully!');
        }

        function updateReferenceRecord() {
            if (!validateReferenceForm()) {
                return;
            }

            var referenceData = {
                references_name: $('#reference_name').val(),
                references_email: $('#reference_email').val(),
                references_mobile: $('#reference_mobile').val(),
                id: referenceRecords[editingReferenceIndex].id
            };

            referenceRecords[editingReferenceIndex] = referenceData;
            displayReferenceRecords();
            clearReferenceForm();
            cancelReferenceEdit();
            showTopRightMessage('Reference updated successfully!');
        }

        function editReferenceRecord(index) {
            var record = referenceRecords[index];
            
            // Fill form data
            $('#reference_name').val(record.references_name);
            $('#reference_email').val(record.references_email);
            $('#reference_mobile').val(record.references_mobile);
            
            // Show update buttons, hide add button
            editingReferenceIndex = index;
            $('#btnAddReference').hide();
            $('#btnUpdateReference').show();
            $('#btnCancelReferenceEdit').show();
            
            showTopRightMessage('Reference loaded for editing!');
        }

        function deleteReferenceRecord(index) {
            if (confirm('Are you sure you want to delete this reference?')) {
                referenceRecords.splice(index, 1);
                displayReferenceRecords();
                showTopRightMessage('Reference deleted successfully!');
            }
        }

        function cancelReferenceEdit() {
            editingReferenceIndex = -1;
            $('#btnAddReference').show();
            $('#btnUpdateReference').hide();
            $('#btnCancelReferenceEdit').hide();
            clearReferenceForm();
        }

        function clearReferenceForm() {
            $('#reference_name').val('');
            $('#reference_email').val('');
            $('#reference_mobile').val('');
            
            // Remove validation classes
            $('#reference_name, #reference_email, #reference_mobile').removeClass('is-invalid');
        }

        function displayReferenceRecords() {
            var container = $('#referencesRecordsList');
            
            if (referenceRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-users fa-2x mb-3"></i>
                        <p>No references added yet. Add your first reference above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Name</th>
                                <th style="font-size: 12px; font-weight: 600;">Email ID</th>
                                <th style="font-size: 12px; font-weight: 600;">Mobile Number</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            referenceRecords.forEach(function (record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">${record.references_name}</td>
                        <td style="font-size: 12px;">${record.references_email}</td>
                        <td style="font-size: 12px;">${record.references_mobile}</td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editReferenceRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteReferenceRecord(${index})" title="Delete Record">
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

        function loadReferenceRecords() {
            $.ajax({
                url: '../../WebService.asmx/GetReferenceDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            referenceRecords = result;
                            displayReferenceRecords();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading reference records:', error);
                }
            });
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
        function validateForm() {
            var isValid = true;
            var errorMessage = '';
            var declarations = ['declaration1', 'declaration2', 'declaration3', 'declaration4', 'declaration5'];
            declarations.forEach(function (id) {
                if (!$('#' + id).is(':checked')) {
                    isValid = false;
                    errorMessage += 'Please accept all declaration statements.\n';
                }
            });
            if (!$('#signatureName').val().trim()) {
                isValid = false;
                errorMessage += 'Please enter your full name as digital signature.\n';
            }
            if (!$('#declarationDate').val()) {
                isValid = false;
                errorMessage += 'Please select the declaration date.\n';
            }

            if (!isValid) {
                showErrorMessage(errorMessage);
            }

            return isValid;
        }

        function saveDeclarationDraft() {
            if (validateForm()) {
                $('#btnSaveDraft').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

                // Prepare all data in single object
                var allData = {
                    declaration: {
                        declarations: {
                            declaration1: $('#declaration1').is(':checked'),
                            declaration2: $('#declaration2').is(':checked'),
                            declaration3: $('#declaration3').is(':checked'),
                            declaration4: $('#declaration4').is(':checked'),
                            declaration5: $('#declaration5').is(':checked')
                        },
                        signatureName: $('#signatureName').val(),
                        declarationdate: $('#declarationDate').val(),
                        additionalcomments: $('#additionalComments').val(),
                        crdfEngagement: $('input[name="crdfEngagement"]:checked').val(),
                        status: 'N'
                    },
                    crdfRecords: crdfRecords,
                    referenceRecords: referenceRecords
                };

              
                $.ajax({
                    url: '../../WebService.asmx/SaveDeclarationData',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ 
                        formDataJson: JSON.stringify(allData.declaration),
                        crdfDataJson: JSON.stringify(allData.crdfRecords),
                        referenceDataJson: JSON.stringify(allData.referenceRecords)
                    }),
                    dataType: 'json',
                    success: function (response) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'All data saved successfully!');
                            $('#btnSaveDraft').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save Draft');
                        } else {
                            showErrorMessage('Failed to save data. Please try again.');
                            $('#btnSaveDraft').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save Draft');
                        }
                    },
                    error: function () {
                        showErrorMessage('An error occurred while saving the data. Please try again.');
                        $('#btnSaveDraft').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save Draft');
                    }
                });
            }
        }

        function submitDeclaration() {
            if (validateForm()) {
                $('#btnSubmitDeclaration').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Submitting...');

                // Prepare all data in single object
                var allData = {
                    declaration: {
                        declarations: {
                            declaration1: $('#declaration1').is(':checked'),
                            declaration2: $('#declaration2').is(':checked'),
                            declaration3: $('#declaration3').is(':checked'),
                            declaration4: $('#declaration4').is(':checked'),
                            declaration5: $('#declaration5').is(':checked')
                        },
                        signatureName: $('#signatureName').val(),
                        declarationdate: $('#declarationDate').val(),
                        additionalcomments: $('#additionalComments').val(),
                        crdfEngagement: $('input[name="crdfEngagement"]:checked').val(),
                        status: 'Y',
                        submittedAt: new Date().toISOString()
                    },
                    crdfRecords: crdfRecords,
                    referenceRecords: referenceRecords
                };

                // Save all data in single web service call
                $.ajax({
                    url: '../../WebService.asmx/SaveDeclarationData',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ 
                        formDataJson: JSON.stringify(allData.declaration),
                        crdfDataJson: JSON.stringify(allData.crdfRecords),
                        referenceDataJson: JSON.stringify(allData.referenceRecords)
                    }),
                    dataType: 'json',
                    success: function (response) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            $('#btnSubmitDeclaration').prop('disabled', true);
                            $('#btnSaveDraft').prop('disabled', true);
                            showTopRightMessage(result.message || 'Declaration submitted successfully!');
                            // Disable form after submission
                            $('#declarationForm input, #declarationForm textarea, #declarationForm button').prop('disabled', true);
                        } else {
                            showErrorMessage('Failed to submit declaration. Please try again.');
                            $('#btnSubmitDeclaration').prop('disabled', false).html('<i class="fas fa-paper-plane me-2"></i>Submit Declaration');
                        }
                    },
                    error: function () {
                        showErrorMessage('An error occurred while submitting the declaration. Please try again.');
                        $('#btnSubmitDeclaration').prop('disabled', false).html('<i class="fas fa-paper-plane me-2"></i>Submit Declaration');
                    }
                });
            }
        }

       
        function getCurrentUserId() {
            // Get user ID from session or global variable
            // This should be set when the user logs in
            if (typeof candidateName !== 'undefined' && candidateName) {
                return candidateName;
            }
            if (typeof userId !== 'undefined' && userId) {
                return userId;
            }
            // Fallback - you may need to adjust this based on your session management
            return '<%= Session["UserId"] ?? "" %>';
        }

        function navigateToPreviousMenu() {
            window.location.href = 'SocialLink.aspx';
        }

        function navigateToPersonalDetailsView() {
            window.location.href = 'PersonalDetailsView.aspx';
        }

        function navigateToNextMenu() {
            // This would typically navigate to a confirmation or completion page
            window.location.href = 'Confirmation.aspx';
        }
    </script>
</asp:Content>
