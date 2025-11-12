<%@ Page Title="Personal Details View" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="PersonalDetailsView.aspx.cs" Inherits="Admin_Profile_PersonalDetailsView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
    Profile Summary
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="profile-summary-tab" role="tabpanel">
                
                <!-- Main Header -->
                <div class="card mb-4">
                    <div class="card-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none;">
                        <h4 class="mb-0 text-white">
                            <i class="fas fa-user-circle me-2"></i>
                            Complete Profile Summary
                        </h4>
                    </div>
                    <div class="card-body" style="display:none;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="alert alert-info mb-0">
                                    <i class="fas fa-info-circle me-2"></i>
                                    <strong>Welcome!</strong> This page provides a comprehensive overview of your complete academic and professional profile.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Year Filter Section -->
                <div class="card mb-4" style="display:none;">
                    <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-filter me-2"></i>
                            Filter by Year
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row align-items-end">
                            <div class="col-md-4">
                                <label class="form-label">Select Academic Year</label>
                                <div class="input-group">
                                    <select id="yearFilter" class="form-select">
                                        <option value="" selected>All Years</option>
                                    </select>
                                    <button type="button" id="btnRefreshYears" class="btn btn-outline-secondary" title="Refresh Year List">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <button type="button" id="btnFilterByYear" class="btn btn-primary btn-sm">
                                    <i class="fas fa-filter me-2"></i>
                                    Apply Filter
                                </button>
                                <button type="button" id="btnClearFilter" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-times me-2"></i>
                                    Show All Years
                                </button>
                            </div>
                            <div class="col-md-4 text-end">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Currently showing: <strong id="currentYearDisplay">All Years</strong>
                                </small>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Personal Details Section -->
                <div class="card mb-4" id="personalDetailsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-user me-2" style="font-size: 0.85rem;"></i>
                            Personal Details
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="personalDetailsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading personal details...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contact Details Section -->
                <div class="card mb-4" id="contactDetailsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-map-marker-alt me-2" style="font-size: 0.85rem;"></i>
                            Contact Details
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="contactDetailsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading contact details...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Education Details Section -->
                <div class="card mb-4" id="educationDetailsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-graduation-cap me-2" style="font-size: 0.85rem;"></i>
                            Education Details
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="educationDetailsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading education details...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bank Account Details Section -->
                <div class="card mb-4" id="bankAccountCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-university me-2" style="font-size: 0.85rem;"></i>
                            Bank Account Details
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="bankAccountContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading bank account details...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Area of Expertise Section -->
                <div class="card mb-4" id="expertiseCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-lightbulb me-2" style="font-size: 0.85rem;"></i>
                            Area of Expertise
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="expertiseContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading area of expertise...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Courses Taught Section -->
                <div class="card mb-4" id="coursesTaughtCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-graduation-cap me-2" style="font-size: 0.85rem;"></i>
                            Courses Taught
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="coursesTaughtContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading courses taught...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Awards & Recognition Section -->
                <div class="card mb-4" id="awardsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-trophy me-2" style="font-size: 0.85rem;"></i>
                            Awards & Recognition
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="awardsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading awards & recognition...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Training Programs Section -->
                <div class="card mb-4" id="trainingProgramsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-chalkboard-teacher me-2" style="font-size: 0.85rem;"></i>
                            Training Programs
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="trainingProgramsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading training programs...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Professional Affiliations Section -->
                <div class="card mb-4" id="affiliationsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-users me-2" style="font-size: 0.85rem;"></i>
                            Professional Affiliations
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="affiliationsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading professional affiliations...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Uploaded Documents Section -->
                <div class="card mb-4" id="uploadedDocumentsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-file-upload me-2" style="font-size: 0.85rem;"></i>
                            Uploaded Documents
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="uploadedDocumentsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading uploaded documents...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Social Links Section -->
                <div class="card mb-4" id="socialLinksCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-share-alt me-2" style="font-size: 0.85rem;"></i>
                            Social Links
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="socialLinksContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading social links...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Stats Cards -->
                <div class="row mb-4" style="display:none;">
                    <div class="col-md-2">
                        <div class="stats-card">
                            <div class="stats-icon bg-primary">
                                <i class="fas fa-graduation-cap"></i>
                            </div>
                            <div class="stats-content">
                                <h3 id="totalEducation">0</h3>
                                <p>Education</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card">
                            <div class="stats-icon bg-success">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="stats-content">
                                <h3 id="totalPublications">0</h3>
                                <p>Publications</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card">
                            <div class="stats-icon bg-info">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stats-content">
                                <h3 id="totalConferences">0</h3>
                                <p>Conferences</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card">
                            <div class="stats-icon bg-warning">
                                <i class="fas fa-microscope"></i>
                            </div>
                            <div class="stats-content">
                                <h3 id="totalResearch">0</h3>
                                <p>Research</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card">
                            <div class="stats-icon bg-danger">
                                <i class="fas fa-flask"></i>
                            </div>
                            <div class="stats-content">
                                <h3 id="totalActivities">0</h3>
                                <p>Activities</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="stats-card">
                            <div class="stats-icon bg-secondary">
                                <i class="fas fa-briefcase"></i>
                            </div>
                            <div class="stats-content">
                                <h3 id="totalExperience">0</h3>
                                <p>Experience</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Experience Summary Section -->
                <div class="card mb-4" id="experienceSummaryCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-briefcase me-2" style="font-size: 0.85rem;"></i>
                            Experience Summary
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="experienceSummaryContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading experience summary...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Publications Section -->
                <div class="card mb-4" id="publicationsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-book me-2" style="font-size: 0.85rem;"></i>
                            Publications
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="publicationsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading publications...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Conferences Section -->
                <div class="card mb-4" id="conferencesCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-users me-2" style="font-size: 0.85rem;"></i>
                            Conferences
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="conferencesContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading conferences...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Research Projects Section -->
                <div class="card mb-4" id="researchCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-microscope me-2" style="font-size: 0.85rem;"></i>
                            Research Projects
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="researchContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading research projects...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Other Research Activities Section -->
                <div class="card mb-4" id="otherResearchCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-flask me-2" style="font-size: 0.85rem;"></i>
                            Other Research Activities
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="otherResearchContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading other research activities...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Experience Details Section -->
                <div class="card mb-4" id="experienceDetailsCard">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-building me-2" style="font-size: 0.85rem;"></i>
                            Experience Details
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="experienceDetailsContent">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin fa-2x mb-2"></i>
                                <p>Loading experience details...</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="card mb-4" style="display:none;">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <button type="button" id="btnRefresh" class="btn btn-primary">
                                    <i class="fas fa-sync-alt me-2"></i>
                                    Refresh All Data
                                </button>
                                <button type="button" id="btnPrint" class="btn btn-secondary">
                                    <i class="fas fa-print me-2"></i>
                                    Print Summary
                                </button>
                            </div>
                            <div>
                                <button type="button" id="btnExport" class="btn btn-success">
                                    <i class="fas fa-file-export me-2"></i>
                                    Export to PDF
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
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
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
            margin: 0;
        }

        .card-body {
            padding: 16px;
        }

        /* Stats Cards */
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .stats-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
        }

        .stats-icon.bg-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .stats-icon.bg-success {
            background: linear-gradient(135deg, #2dce89 0%, #2dcecc 100%);
        }

        .stats-icon.bg-info {
            background: linear-gradient(135deg, #11cdef 0%, #1171ef 100%);
        }

        .stats-icon.bg-warning {
            background: linear-gradient(135deg, #fb6340 0%, #fbb140 100%);
        }

        .stats-content h3 {
            margin: 0;
            font-size: 32px;
            font-weight: 700;
            color: #32325d;
        }

        .stats-content p {
            margin: 0;
            color: #8898aa;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
        }

        /* Gradient Headers */
        .bg-gradient-primary {
            background: linear-gradient(87deg, #5e72e4 0, #825ee4 100%) !important;
        }

        .bg-gradient-success {
            background: linear-gradient(87deg, #2dce89 0, #2dcecc 100%) !important;
        }

        .bg-gradient-info {
            background: linear-gradient(87deg, #11cdef 0, #1171ef 100%) !important;
        }

        .bg-gradient-warning {
            background: linear-gradient(87deg, #fb6340 0, #fbb140 100%) !important;
        }

        .bg-gradient-danger {
            background: linear-gradient(87deg, #f5365c 0, #f56036 100%) !important;
        }

        .bg-gradient-secondary {
            background: linear-gradient(87deg, #6c757d 0, #5a6268 100%) !important;
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

        .badge {
            font-size: 10px;
            padding: 4px 8px;
        }

        .btn {
            padding: 8px 16px;
            font-size: 13px;
            border-radius: 4px;
            border: 1px solid transparent;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border-color: #007bff;
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            border-color: #28a745;
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border-color: #6c757d;
            color: white;
        }

        .summary-row {
            padding: 12px;
            margin-bottom: 8px;
            background-color: #f8f9fa;
            border-radius: 6px;
            border-left: 4px solid #007bff;
        }

        .summary-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 4px;
        }

        .summary-value {
            color: #32325d;
            font-size: 14px;
        }

        .form-label {
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 6px;
            color: #495057;
        }

        .form-select {
            padding: 8px 12px;
            font-size: 13px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            background-color: #fff;
        }

        .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .year-filter-active {
            border: 2px solid #28a745 !important;
            background-color: #d4edda !important;
        }

        /* Personal Details Display */
        .detail-row {
            display: flex;
            padding: 10px 12px;
            margin-bottom: 6px;
            background-color: #ffffff;
            border-radius: 6px;
            border: 1px solid #e9ecef;
            transition: all 0.2s ease;
        }

        .detail-row:hover {
            background-color: #f8f9fa;
            border-color: #007bff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .detail-label {
            font-weight: 600;
            color: #495057;
            min-width: 250px;
            font-size: 13px;
            display: flex;
            align-items: center;
        }

        .detail-label i {
            margin-right: 8px;
            color: #007bff;
            font-size: 14px;
            width: 16px;
        }

        .detail-value {
            color: #32325d;
            font-size: 13px;
            flex: 1;
            padding-left: 15px;
            border-left: 2px solid #e9ecef;
        }

        .detail-value.empty {
            color: #adb5bd;
            font-style: italic;
        }

        .profile-image-display {
            text-align: center;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .profile-image-display img {
            max-width: 150px;
            max-height: 150px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            object-fit: cover;
        }

        .section-subtitle {
            font-size: 14px;
            font-weight: 600;
            color: #495057;
            padding: 10px 12px;
            background-color: #e9ecef;
            border-radius: 4px;
            margin-bottom: 12px;
            margin-top: 8px;
        }

        .section-subtitle i {
            color: #007bff;
        }

        @media print {
            .btn, #btnRefresh, #btnPrint, #btnExport {
                display: none !important;
            }
            
            .card {
                break-inside: avoid;
                page-break-inside: avoid;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .personal-details-container {
                margin: 10px;
                padding: 15px;
            }
            
            .stats-card {
                padding: 15px;
            }
            
            .stats-icon {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
            
            .stats-content h3 {
                font-size: 24px;
            }
            
            .detail-row {
                flex-direction: column;
                padding: 12px;
            }
            
            .detail-label {
                min-width: 100%;
                margin-bottom: 8px;
                padding-bottom: 8px;
                border-bottom: 1px solid #e9ecef;
            }
            
            .detail-value {
                padding-left: 0;
                border-left: none;
                padding-left: 24px;
            }
        }

        .bg-purple {
            background-color: #6f42c1 !important;
            color: white !important;
        }

        /* Two Column Layout for Personal Details */
        .personal-details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 15px;
        }

        .detail-row-grid {
            display: flex;
            flex-direction: column;
            padding: 10px 12px;
            background-color: #ffffff;
            border-radius: 6px;
            border: 1px solid #e9ecef;
            transition: all 0.2s ease;
        }

        .detail-row-grid:hover {
            background-color: #f8f9fa;
            border-color: #007bff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .detail-label-grid {
            font-weight: 600;
            color: #495057;
            font-size: 12px;
            display: flex;
            align-items: center;
            margin-bottom: 6px;
            padding-bottom: 6px;
            border-bottom: 2px solid #e9ecef;
        }

        .detail-label-grid i {
            margin-right: 8px;
            color: #007bff;
            font-size: 14px;
            width: 16px;
        }

        .detail-value-grid {
            color: #32325d;
            font-size: 13px;
            padding-left: 24px;
        }

        .detail-value-grid.empty {
            color: #adb5bd;
            font-style: italic;
        }

        @media (max-width: 992px) {
            .personal-details-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <script>
        var currentSelectedYear = ''; // Track selected year filter
        
        $(document).ready(function () {
            // Load year options first
            loadYearOptions();
            
            // Load all data on page load
            loadAllProfileData();

            // Year filter buttons
            $('#btnFilterByYear').click(function() {
                var selectedYear = $('#yearFilter').val();
                currentSelectedYear = selectedYear;
                
                if (selectedYear) {
                    $('#currentYearDisplay').text($('#yearFilter option:selected').text());
                    $('#yearFilter').addClass('year-filter-active');
                    showMessage('Filtering data for: ' + $('#yearFilter option:selected').text(), 'success');
                } else {
                    $('#currentYearDisplay').text('All Years');
                    $('#yearFilter').removeClass('year-filter-active');
                    showMessage('Showing all years', 'info');
                }
                
                loadAllProfileData();
            });

            $('#btnClearFilter').click(function() {
                currentSelectedYear = '';
                $('#yearFilter').val('');
                $('#yearFilter').removeClass('year-filter-active');
                $('#currentYearDisplay').text('All Years');
                showMessage('Filter cleared - showing all years', 'info');
                loadAllProfileData();
            });

            // Refresh year list button
            $('#btnRefreshYears').click(function() {
                var btn = $(this);
                var originalHtml = btn.html();
                btn.html('<i class="fas fa-spinner fa-spin"></i>').prop('disabled', true);
                
                // First try to load from web service, then fallback to generate
                loadYearOptions();
                
                setTimeout(function() {
                    btn.html(originalHtml).prop('disabled', false);
                    showMessage('Year list refreshed successfully!', 'success');
                }, 1000);
            });

            // Refresh button
            $('#btnRefresh').click(function() {
                $(this).html('<i class="fas fa-spinner fa-spin me-2"></i>Refreshing...');
                loadAllProfileData();
                setTimeout(function() {
                    $('#btnRefresh').html('<i class="fas fa-sync-alt me-2"></i>Refresh All Data');
                }, 2000);
            });

            // Print button
            $('#btnPrint').click(function() {
                window.print();
            });

            // Export to PDF button (placeholder)
            $('#btnExport').click(function() {
                showMessage('Export to PDF functionality coming soon!', 'info');
            });
        });

        function loadYearOptions() {
            $.ajax({
                url: '../../WebService.asmx/GetYearData',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            $('#yearFilter').find('option:not(:first)').remove();
                            
                            $.each(result, function(index, item) {
                                var yearCode = item.YearCode || item.yearCode || item.year_code;
                                var yearName = item.YearName || item.yearName || item.year_name || yearCode;
                                
                                var option = $('<option></option>')
                                    .attr('value', yearCode)
                                    .text(yearName);
                                $('#yearFilter').append(option);
                            });
                        } else {
                            // Fallback: Generate years dynamically if no data from web service
                            generateYearOptions();
                        }
                    } catch (e) {
                        console.error('Error loading year options:', e);
                        // Fallback: Generate years dynamically
                        generateYearOptions();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load year options:', error);
                    // Fallback: Generate years dynamically
                    generateYearOptions();
                }
            });
        }

        function generateYearOptions() {
            $('#yearFilter').find('option:not(:first)').remove();
            
            var currentYear = new Date().getFullYear();
            var startYear = currentYear - 15; // Go back 15 years
            var endYear = currentYear + 2; // Include next 2 years for planning
            
            var years = [];
            
            // Generate academic year format (e.g., 2024-2025, 2023-2024)
            for (var year = endYear; year >= startYear; year--) {
                var academicYear = year + '-' + (year + 1);
                years.push({
                    code: academicYear,
                    name: academicYear
                });
                
                // Also add single year format
                years.push({
                    code: year.toString(),
                    name: year.toString()
                });
            }
            
            // Remove duplicates and sort
            var uniqueYears = [];
            var seen = {};
            years.forEach(function(item) {
                if (!seen[item.code]) {
                    seen[item.code] = true;
                    uniqueYears.push(item);
                }
            });
            
            // Sort by year descending
            uniqueYears.sort(function(a, b) {
                var yearA = parseInt(a.code.split('-')[0]);
                var yearB = parseInt(b.code.split('-')[0]);
                return yearB - yearA;
            });
            
            // Add to dropdown
            $.each(uniqueYears, function(index, item) {
                var option = $('<option></option>')
                    .attr('value', item.code)
                    .text(item.name);
                $('#yearFilter').append(option);
            });
            
            console.log('Generated ' + uniqueYears.length + ' year options dynamically');
        }

        function loadAllProfileData() {
            loadPersonalDetails();
            loadContactDetails();
            loadEducationDetails();
            loadBankAccountDetails();
            loadAreaOfExpertise();
            loadCoursesTaught();
            loadAwards();
            loadTrainingPrograms();
            loadAffiliations();
            loadUploadedDocuments();
            loadSocialLinks();
            loadExperienceSummary();
            loadPublications();
            loadConferences();
            loadResearchProjects();
            loadOtherResearchActivities();
            loadExperienceDetails();
        }

        function loadSocialLinks() {
            console.log('Loading social links...');
            $.ajax({
                url: '../../WebService.asmx/GetSocialLinks',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    console.log('Social links response:', response);
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        console.log('Social links data:', result);
                        console.log('Social links count:', result ? result.length : 0);
                        
                        if (result && result.length > 0) {
                            displaySocialLinks(result);
                        } else {
                            $('#socialLinksContent').html('<div class="alert alert-warning">No social links added yet.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading social links:', e);
                        $('#socialLinksContent').html('<div class="alert alert-danger">Error loading social links.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load social links:', error);
                    $('#socialLinksContent').html('<div class="alert alert-danger">Failed to load social links.</div>');
                }
            });
        }

        function displaySocialLinks(data) {
            console.log('displaySocialLinks called with:', data);
            
            if (data.length === 0) {
                $('#socialLinksContent').html('<div class="alert alert-warning">No social links found.</div>');
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Platform</th>
                                <th>Display Name</th>
                                <th>URL</th>
                                <th>Visibility</th>
                                <th>Priority</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            data.forEach(function(link, index) {
                var platform = link.platform || link.Platform || 'OTHER';
                var customPlatform = link.customPlatform || link.CustomPlatform || '';
                var url = link.url || link.Url || link.URL || '';
                var displayName = link.displayName || link.DisplayName || link.display_name || '';
                var description = link.description || link.Description || '';
                var visibility = link.visibility || link.Visibility || 'PUBLIC';
                var priority = link.priority || link.Priority || 'MEDIUM';
                
                var platformName = platform === 'OTHER' && customPlatform ? customPlatform : platform;
                var platformIcon = getSocialPlatformIcon(platform);
                var platformColor = getSocialPlatformColor(platform);
                
                // Truncate URL for display
                var displayUrl = url.length > 40 ? url.substring(0, 40) + '...' : url;
                
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>
                            <span style="color: ${platformColor};">
                                <i class="${platformIcon} me-2"></i>
                                <strong>${platformName}</strong>
                            </span>
                        </td>
                        <td>${displayName || '-'}</td>
                        <td>
                            <small style="color: #6c757d;" title="${url}">${displayUrl}</small>
                        </td>
                        <td><span class="badge ${getVisibilityBadgeClass(visibility)}">${visibility}</span></td>
                        <td><span class="badge ${getPriorityBadgeClass(priority)}">${priority}</span></td>
                        <td>
                            <a href="${url}" target="_blank" class="btn btn-sm btn-outline-primary">
                                <i class="fas fa-external-link-alt"></i>
                            </a>
                        </td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#socialLinksContent').html(html);
        }

        function getSocialPlatformIcon(platform) {
            switch(platform) {
                case 'LINKEDIN': return 'fab fa-linkedin';
                case 'TWITTER': return 'fab fa-twitter';
                case 'FACEBOOK': return 'fab fa-facebook';
                case 'INSTAGRAM': return 'fab fa-instagram';
                case 'GITHUB': return 'fab fa-github';
                case 'YOUTUBE': return 'fab fa-youtube';
                case 'WEBSITE': return 'fas fa-globe';
                case 'PORTFOLIO': return 'fas fa-briefcase';
                case 'BEHANCE': return 'fab fa-behance';
                case 'DRIBBBLE': return 'fab fa-dribbble';
                case 'STACKOVERFLOW': return 'fab fa-stack-overflow';
                case 'MEDIUM': return 'fab fa-medium';
                default: return 'fas fa-link';
            }
        }

        function getSocialPlatformColor(platform) {
            switch(platform) {
                case 'LINKEDIN': return '#0077b5';
                case 'TWITTER': return '#1da1f2';
                case 'FACEBOOK': return '#1877f2';
                case 'INSTAGRAM': return '#e4405f';
                case 'GITHUB': return '#333333';
                case 'YOUTUBE': return '#ff0000';
                case 'WEBSITE': return '#007bff';
                case 'PORTFOLIO': return '#6c757d';
                case 'BEHANCE': return '#1769ff';
                case 'DRIBBBLE': return '#ea4c89';
                case 'STACKOVERFLOW': return '#f48024';
                case 'MEDIUM': return '#00ab6c';
                default: return '#6c757d';
            }
        }

        function getVisibilityBadgeClass(visibility) {
            switch(visibility) {
                case 'PUBLIC': return 'bg-success';
                case 'PRIVATE': return 'bg-danger';
                case 'PROFESSIONAL': return 'bg-warning text-dark';
                default: return 'bg-secondary';
            }
        }

        function getPriorityBadgeClass(priority) {
            switch(priority) {
                case 'HIGH': return 'bg-danger';
                case 'MEDIUM': return 'bg-warning text-dark';
                case 'LOW': return 'bg-secondary';
                default: return 'bg-secondary';
            }
        }

        function loadUploadedDocuments() {
            console.log('Loading uploaded documents...');
            
            $.ajax({
                url: '../../WebService.asmx/GetDocumentIdentityDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    console.log('Uploaded documents response:', response);
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        console.log('Result after d check:', result);
                        console.log('Result type:', typeof result);
                        console.log('Is array?', Array.isArray(result));
                        console.log('Result length:', result ? result.length : 0);
                        
                        var doc = [];
                        var identities = [];
                        
                        // Handle the specific format: result[0] = documents, result[1] = identities
                        if (result && Array.isArray(result) && result.length > 0) {
                            console.log('Processing 2-element array format...');
                            
                            // Parse documents from result[0]
                            if (result.length > 0 && result[0]) {
                                console.log('Parsing documents from result[0]:', result[0]);
                                try {
                                    doc = typeof result[0] === 'string' ? JSON.parse(result[0]) : result[0];
                                    console.log('Documents parsed:', doc);
                                    console.log('Documents count:', doc.length);
                                } catch (e) {
                                    console.error('Error parsing documents:', e);
                                }
                            }
                            
                            // Parse identities from result[1]
                            if (result.length > 1 && result[1]) {
                                console.log('Parsing identities from result[1]:', result[1]);
                                try {
                                    identities = typeof result[1] === 'string' ? JSON.parse(result[1]) : result[1];
                                    console.log('Identities parsed:', identities);
                                    console.log('Identities count:', identities.length);
                                } catch (e) {
                                    console.error('Error parsing identities:', e);
                                }
                            }
                        }
                        
                        // Display documents and identities
                        if ((doc && doc.length > 0 && Array.isArray(doc)) || (identities && identities.length > 0 && Array.isArray(identities))) {
                            loadDocumentsAndIdentitiesToTable(doc, identities);
                        } else {
                            console.warn('No documents or identities found');
                            $('#uploadedDocumentsContent').html('<div class="alert alert-warning"><i class="fas fa-info-circle me-2"></i>No documents uploaded yet. Upload documents via <a href="UploadDocument.aspx">Upload Document</a> page.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading uploaded documents:', e);
                        console.error('Error details:', e.message, e.stack);
                        $('#uploadedDocumentsContent').html('<div class="alert alert-danger"><i class="fas fa-exclamation-triangle me-2"></i>Error loading uploaded documents: ' + e.message + '</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load uploaded documents:', error);
                    console.error('XHR status:', xhr.status);
                    console.error('XHR response:', xhr.responseText);
                    var errorMsg = 'Failed to load uploaded documents';
                    if (xhr.status === 404) {
                        errorMsg = 'Web service not found (404). Please check if GetDocumentIdentityDetails exists.';
                    } else if (xhr.status === 500) {
                        errorMsg = 'Server error (500). Please check web service configuration.';
                    }
                    $('#uploadedDocumentsContent').html('<div class="alert alert-danger"><i class="fas fa-exclamation-triangle me-2"></i>' + errorMsg + '</div>');
                }
            });
        }

        function loadDocumentsAndIdentitiesToTable(doc, identities) {
            console.log('loadDocumentsAndIdentitiesToTable called');
            console.log('Documents:', doc);
            console.log('Identities:', identities);
            
            var html = '';
            var hasContent = false;

            // Load General Documents
            if (doc && doc.length > 0 && Array.isArray(doc)) {
                hasContent = true;
                console.log('Loading documents to table, count:', doc.length);
                html += loadDocumentsToTable(doc);
            }

            // Load Identity Documents
            if (identities && identities.length > 0 && Array.isArray(identities)) {
                hasContent = true;
                console.log('Loading identities to table, count:', identities.length);
                html += loadIdentitiesToTable(identities);
            }

            if (hasContent) {
                $('#uploadedDocumentsContent').html(html);
            } else {
                $('#uploadedDocumentsContent').html('<div class="alert alert-warning"><i class="fas fa-info-circle me-2"></i>No documents uploaded yet.</div>');
            }
        }

        function loadDocumentsToTable(doc) {
            console.log('loadDocumentsToTable called with:', doc);
            
            // Group documents by type
            var documentsByType = {};
            
            doc.forEach(function(document, index) {
                var docTypeName = document.document_name || document.Document_name || document.document_type || document.Document_type || 'Other Documents';
                
                if (!documentsByType[docTypeName]) {
                    documentsByType[docTypeName] = [];
                }
                documentsByType[docTypeName].push(document);
            });
            
            console.log('Documents grouped by type:', documentsByType);
            
            var html = `
                <h6 class="mb-3" style="color: #495057; font-weight: 600; font-size: 1rem;">
                    <i class="fas fa-folder me-2" style="color: #007bff;"></i>
                    General Documents
                </h6>
            `;

            for (var typeName in documentsByType) {
                var docs = documentsByType[typeName];
                html += `
                    <div class="mb-4">
                        <h6 class="mb-2" style="color: #6c757d; font-weight: 500; font-size: 0.9rem;">
                            <i class="fas fa-file-alt me-2" style="color: #007bff; font-size: 0.85rem;"></i>
                            ${typeName} (${docs.length})
                        </h6>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th width="10%">S.No</th>
                                        <th width="50%">File Type</th>
                                        <th width="50%">File Name</th>
                                        <th width="40%">Uploaded Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                `;

                docs.forEach(function(document, index) {
                    var fileName = document.file_name || document.File_name || document.document_ref || document.ref_file_name || 'N/A';
                    var fileType = document.file_name || document.File_name || document.document_ref || document.ref_name || 'N/A';
                    var uploadedDate = document.uploaded_date || document.Uploaded_date || document.created_date || document.Created_date || '';
                    
                    html += `
                        <tr>
                            <td>${index + 1}</td>
                            <td><i class="fas fa-file-pdf me-2" style="color: #dc3545;"></i>${fileType}</td>
                            <td><i class="fas fa-file-pdf me-2" style="color: #dc3545;"></i>${fileName}</td>
                            <td>${formatDateForDisplay(uploadedDate) || 'N/A'}</td>
                        </tr>
                    `;
                });

                html += `
                                </tbody>
                            </table>
                        </div>
                    </div>
                `;
            }

            return html;
        }

        function loadIdentitiesToTable(identities) {
            console.log('loadIdentitiesToTable called with:', identities);
            
            // Group identities by type
            var identitiesByType = {};
            
            identities.forEach(function(identity, index) {
                var identityTypeName = identity.identity_name || identity.Identity_name || identity.identity_type || identity.Identity_type || 'Other Identity';
                
                if (!identitiesByType[identityTypeName]) {
                    identitiesByType[identityTypeName] = [];
                }
                identitiesByType[identityTypeName].push(identity);
            });
            
            console.log('Identities grouped by type:', identitiesByType);
            
            var html = `
                <h6 class="mb-3 mt-4" style="color: #495057; font-weight: 600; font-size: 1rem;">
                    <i class="fas fa-id-card me-2" style="color: #28a745;"></i>
                    Identity Documents
                </h6>
            `;

            for (var typeName in identitiesByType) {
                var ids = identitiesByType[typeName];
                html += `
                    <div class="mb-4">
                        <h6 class="mb-2" style="color: #6c757d; font-weight: 500; font-size: 0.9rem;">
                            <i class="fas fa-id-badge me-2" style="color: #28a745; font-size: 0.85rem;"></i>
                            ${typeName} (${ids.length})
                        </h6>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover table-sm">
                                <thead>
                                    <tr>
                                        <th width="10%">S.No</th>
                                        <th width="30%">Identity Number</th>
                                        <th width="30%">Identity Type</th>
                                        <th width="40%">File Name</th>
                                        <th width="20%">Uploaded Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                `;

                ids.forEach(function(identity, index) {
                    var identityNumber = identity.identity_number || identity.Identity_number || 'N/A';
                    var fileType = identity.file_name || identity.File_name || identity.document_ref || identity.Identity_name || 'N/A';
                    var fileName = identity.file_name || identity.File_name || identity.document_ref || identity.Identity_document || 'N/A';
                    var uploadedDate = identity.uploaded_date || identity.Uploaded_date || identity.created_date || identity.Created_date || '';
                    
                    html += `
                        <tr>
                            <td>${index + 1}</td>
                            <td><strong style="color: #495057;">${fileType}</strong></td>
                            <td><strong style="color: #495057;">${identityNumber}</strong></td>
                            <td><i class="fas fa-file-image me-2" style="color: #28a745;"></i>${fileName}</td>
                            <td>${formatDateForDisplay(uploadedDate) || 'N/A'}</td>
                        </tr>
                    `;
                });

                html += `
                                </tbody>
                            </table>
                        </div>
                    </div>
                `;
            }

            return html;
        }

        function getDocumentTypeBadgeClass(type) {
            var typeStr = type.toString().toLowerCase();
            if (typeStr.includes('cv') || typeStr.includes('resume')) return 'bg-success';
            if (typeStr.includes('portfolio')) return 'bg-primary';
            if (typeStr.includes('certificate')) return 'bg-warning text-dark';
            if (typeStr.includes('transcript')) return 'bg-purple';
            if (typeStr.includes('publication')) return 'bg-danger';
            if (typeStr.includes('photo') || typeStr.includes('image')) return 'bg-info';
            return 'bg-secondary';
        }

        function getIdentityTypeBadgeClass(type) {
            var typeStr = type.toString().toLowerCase();
            if (typeStr.includes('pan')) return 'bg-info';
            if (typeStr.includes('aadhar') || typeStr.includes('aadhaar')) return 'bg-purple';
            if (typeStr.includes('passport')) return 'bg-success';
            if (typeStr.includes('oci')) return 'bg-warning text-dark';
            if (typeStr.includes('coa')) return 'bg-danger';
            if (typeStr.includes('voter')) return 'bg-primary';
            return 'bg-secondary';
        }

        function loadAffiliations() {
            $.ajax({
                url: '../../WebService.asmx/GetAffiliationsDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayAffiliations(result);
                        } else {
                            $('#affiliationsContent').html('<div class="alert alert-warning">No professional affiliations found.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading affiliations:', e);
                        $('#affiliationsContent').html('<div class="alert alert-danger">Error loading professional affiliations.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load affiliations:', error);
                    $('#affiliationsContent').html('<div class="alert alert-danger">Failed to load professional affiliations.</div>');
                }
            });
        }

        function displayAffiliations(data) {
            // Filter by year if year filter is applied
            var filteredData = data;
            if (currentSelectedYear) {
                var selectedYearNum = currentSelectedYear.split('-')[0];
                filteredData = data.filter(function(affiliation) {
                    var startDate = affiliation.start_date || affiliation.Start_date || '';
                    var endDate = affiliation.end_date || affiliation.End_date || '';
                    
                    // Extract year from start date
                    if (startDate) {
                        var startYearMatch = startDate.toString().match(/\d{4}/);
                        if (startYearMatch && startYearMatch[0] === selectedYearNum) {
                            return true;
                        }
                    }
                    
                    // Extract year from end date
                    if (endDate) {
                        var endYearMatch = endDate.toString().match(/\d{4}/);
                        if (endYearMatch && endYearMatch[0] === selectedYearNum) {
                            return true;
                        }
                    }
                    
                    return false;
                });
            }
            
            if (filteredData.length === 0) {
                $('#affiliationsContent').html('<div class="alert alert-warning">No affiliations found for selected year.</div>');
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Organization</th>
                                <th>Position</th>
                                <th>Type</th>
                                <th>Level</th>
                                <th>Period</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            filteredData.forEach(function(affiliation, index) {
                var orgName = affiliation.organization_name || affiliation.Organization_name || 'N/A';
                var position = affiliation.position_title || affiliation.Position_title || 'N/A';
                var type = affiliation.affiliation_type || affiliation.Affiliation_type || 'N/A';
                var level = affiliation.membership_level || affiliation.Membership_level || 'N/A';
                var startDate = affiliation.start_date || affiliation.Start_date || '';
                var endDate = affiliation.end_date || affiliation.End_date || '';
                var status = affiliation.status || affiliation.Status || 'ACTIVE';
                
                // Format period
                var period = formatDateForDisplay(startDate) || 'N/A';
                if (endDate) {
                    period += ' - ' + formatDateForDisplay(endDate);
                } else {
                    period += ' - Present';
                }
                
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><strong>${orgName}</strong></td>
                        <td>${position}</td>
                        <td><span class="badge ${getAffiliationTypeBadgeClass(type)}">${type}</span></td>
                        <td><span class="badge ${getMembershipLevelBadgeClass(level)}">${level}</span></td>
                        <td>${period}</td>
                        <td><span class="badge ${getAffiliationStatusBadgeClass(status)}">${status}</span></td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#affiliationsContent').html(html);
        }

        function getAffiliationTypeBadgeClass(type) {
            switch(type) {
                case 'PROFESSIONAL': return 'bg-primary';
                case 'ACADEMIC': return 'bg-success';
                case 'RESEARCH': return 'bg-info';
                case 'GOVERNMENT': return 'bg-warning text-dark';
                case 'NONPROFIT': return 'bg-secondary';
                case 'INDUSTRY': return 'bg-danger';
                case 'INTERNATIONAL': return 'bg-dark';
                default: return 'bg-light text-dark';
            }
        }

        function getMembershipLevelBadgeClass(level) {
            switch(level) {
                case 'FELLOW': return 'bg-danger';
                case 'LIFETIME': return 'bg-warning text-dark';
                case 'BOARD': return 'bg-dark';
                case 'MEMBER': return 'bg-primary';
                case 'ASSOCIATE': return 'bg-info';
                case 'STUDENT': return 'bg-secondary';
                case 'HONORARY': return 'bg-success';
                case 'COMMITTEE': return 'bg-primary';
                default: return 'bg-light text-dark';
            }
        }

        function getAffiliationStatusBadgeClass(status) {
            switch(status) {
                case 'ACTIVE': return 'bg-success';
                case 'INACTIVE': return 'bg-secondary';
                case 'EXPIRED': return 'bg-danger';
                case 'SUSPENDED': return 'bg-warning text-dark';
                default: return 'bg-light text-dark';
            }
        }

        function loadTrainingPrograms() {
            $.ajax({
                url: '../../WebService.asmx/GetTrainingProgramsDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayTrainingPrograms(result);
                        } else {
                            $('#trainingProgramsContent').html('<div class="alert alert-warning">No training programs found.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading training programs:', e);
                        $('#trainingProgramsContent').html('<div class="alert alert-danger">Error loading training programs.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load training programs:', error);
                    $('#trainingProgramsContent').html('<div class="alert alert-danger">Failed to load training programs.</div>');
                }
            });
        }

        function displayTrainingPrograms(data) {
            // Filter by year if year filter is applied
            var filteredData = data;
            if (currentSelectedYear) {
                var selectedYearNum = currentSelectedYear.split('-')[0];
                filteredData = data.filter(function(program) {
                    var startDate = program.start_date || program.Start_date || '';
                    var endDate = program.end_date || program.End_date || '';
                    
                    // Extract year from start date
                    if (startDate) {
                        var startYearMatch = startDate.toString().match(/\d{4}/);
                        if (startYearMatch && startYearMatch[0] === selectedYearNum) {
                            return true;
                        }
                    }
                    
                    // Extract year from end date
                    if (endDate) {
                        var endYearMatch = endDate.toString().match(/\d{4}/);
                        if (endYearMatch && endYearMatch[0] === selectedYearNum) {
                            return true;
                        }
                    }
                    
                    return false;
                });
            }
            
            if (filteredData.length === 0) {
                $('#trainingProgramsContent').html('<div class="alert alert-warning">No training programs found for selected year.</div>');
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Type</th>
                                <th>Title</th>
                                <th>Organizer</th>
                                <th>Duration</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Participants</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            filteredData.forEach(function(program, index) {
                var typeCode = program.typeCode || program.TypeCode || 'N/A';
                var title = program.title || program.Title || 'N/A';
                var description = program.description || program.Description || '';
                var duration = program.duration || program.Duration || 'N/A';
                var startDate = program.start_date || program.Start_date || '';
                var endDate = program.end_date || program.End_date || '';
                var organizer = program.organizer || program.Organizer || 'N/A';
                var participants = program.no_of_participants || program.No_of_participants || 'N/A';
                
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><span class="badge ${getTrainingTypeBadgeClass(typeCode)}">${typeCode}</span></td>
                        <td><strong>${title}</strong></td>
                        <td>${organizer}</td>
                        <td>${duration} days</td>
                        <td>${formatDateForDisplay(startDate) || 'N/A'}</td>
                        <td>${formatDateForDisplay(endDate) || 'N/A'}</td>
                        <td>${participants}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#trainingProgramsContent').html(html);
        }

        function getTrainingTypeBadgeClass(type) {
            switch(type) {
                case 'WORKSHOP': return 'bg-primary';
                case 'SEMINAR': return 'bg-success';
                case 'CONFERENCE': return 'bg-info';
                case 'TRAINING': return 'bg-warning text-dark';
                case 'CERTIFICATION': return 'bg-danger';
                case 'WEBINAR': return 'bg-secondary';
                case 'COURSE': return 'bg-dark';
                default: return 'bg-light text-dark';
            }
        }

        function loadAwards() {
            $.ajax({
                url: '../../WebService.asmx/GetAwardsDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayAwards(result);
                        } else {
                            $('#awardsContent').html('<div class="alert alert-warning">No awards & recognition records found.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading awards:', e);
                        $('#awardsContent').html('<div class="alert alert-danger">Error loading awards & recognition.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load awards:', error);
                    $('#awardsContent').html('<div class="alert alert-danger">Failed to load awards & recognition.</div>');
                }
            });
        }

        function displayAwards(data) {
            // Filter by year if year filter is applied
            var filteredData = data;
            if (currentSelectedYear) {
                var selectedYearNum = currentSelectedYear.split('-')[0];
                filteredData = data.filter(function(award) {
                    var awardYear = award.year_code || award.Year_code || '';
                    var awardDate = award.date || award.Date || '';
                    
                    // Check if year_code matches
                    if (awardYear && awardYear.toString() === selectedYearNum) {
                        return true;
                    }
                    
                    // Check if year_code matches full academic year
                    if (awardYear && awardYear.toString() === currentSelectedYear) {
                        return true;
                    }
                    
                    // Extract year from date
                    if (awardDate) {
                        var dateYearMatch = awardDate.toString().match(/\d{4}/);
                        if (dateYearMatch && dateYearMatch[0] === selectedYearNum) {
                            return true;
                        }
                    }
                    
                    return false;
                });
            }
            
            if (filteredData.length === 0) {
                $('#awardsContent').html('<div class="alert alert-warning">No awards found for selected year.</div>');
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Year</th>
                                <th>Type</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            filteredData.forEach(function(award, index) {
                // Extract year
                var year = award.year_code || award.Year_code || '';
                if (!year && award.date) {
                    var dateMatch = award.date.toString().match(/\d{4}/);
                    year = dateMatch ? dateMatch[0] : '';
                }
                
                // Truncate description
                var description = award.description || award.Description || '';
                var truncatedDesc = description.length > 80 ? description.substring(0, 80) + '...' : description;
                
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><span class="badge bg-warning text-dark">${year || 'N/A'}</span></td>
                        <td><span class="badge bg-success">${award.type || award.Type || 'N/A'}</span></td>
                        <td><strong>${award.title || award.Title || 'N/A'}</strong></td>
                        <td>${truncatedDesc || 'N/A'}</td>
                        <td>${formatDateForDisplay(award.date || award.Date) || 'N/A'}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#awardsContent').html(html);
        }

        function loadCoursesTaught() {
            $.ajax({
                url: '../../WebService.asmx/GetCourseTaughtDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayCoursesTaught(result);
                        } else {
                            $('#coursesTaughtContent').html('<div class="alert alert-warning">No courses taught records found.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading courses taught:', e);
                        $('#coursesTaughtContent').html('<div class="alert alert-danger">Error loading courses taught.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load courses taught:', error);
                    $('#coursesTaughtContent').html('<div class="alert alert-danger">Failed to load courses taught.</div>');
                }
            });
        }

        function displayCoursesTaught(data) {
            // Filter by year if year filter is applied
            var filteredData = data;
            if (currentSelectedYear) {
                filteredData = data.filter(function(course) {
                    var courseYear = course.semester_year || course.Semester_year || '';
                    return courseYear && courseYear === currentSelectedYear.split('-')[0];
                });
            }
            
            if (filteredData.length === 0) {
                $('#coursesTaughtContent').html('<div class="alert alert-warning">No courses taught found for selected year.</div>');
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Course Code</th>
                                <th>Course Title</th>
                                <th>Semester Year</th>
                                <th>Semester Type</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            filteredData.forEach(function(course, index) {
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><span class="badge bg-primary">${course.course_code || course.Course_code || 'N/A'}</span></td>
                        <td><strong>${course.title || course.Title || 'N/A'}</strong></td>
                        <td>${course.semester_year || course.Semester_year || 'N/A'}</td>
                        <td><span class="badge ${getSemesterTypeBadgeClass(course.semester_type || course.Semester_type)}">${course.semester_type || course.Semester_type || 'N/A'}</span></td>
                        <td><span class="badge ${getCourseStatusBadgeClass(course.is_active || course.Is_active)}">${getCourseStatusText(course.is_active || course.Is_active)}</span></td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#coursesTaughtContent').html(html);
        }

        function getSemesterTypeBadgeClass(semesterType) {
            switch(semesterType) {
                case 'Fall': return 'bg-warning';
                case 'Spring': return 'bg-success';
                case 'Summer': return 'bg-info';
                case 'Winter': return 'bg-secondary';
                default: return 'bg-light text-dark';
            }
        }

        function getCourseStatusBadgeClass(isActive) {
            return isActive === '1' || isActive === 1 || isActive === true ? 'bg-success' : 'bg-danger';
        }

        function getCourseStatusText(isActive) {
            return isActive === '1' || isActive === 1 || isActive === true ? 'Active' : 'Inactive';
        }

        function loadAreaOfExpertise() {
            $.ajax({
                url: '../../WebService.asmx/GetExpertiseDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayAreaOfExpertise(result);
                        } else {
                            $('#expertiseContent').html('<div class="alert alert-warning">No area of expertise added yet.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading area of expertise:', e);
                        $('#expertiseContent').html('<div class="alert alert-danger">Error loading area of expertise.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load area of expertise:', error);
                    $('#expertiseContent').html('<div class="alert alert-danger">Failed to load area of expertise.</div>');
                }
            });
        }

        function displayAreaOfExpertise(data) {
            if (data.length === 0) {
                $('#expertiseContent').html('<div class="alert alert-warning">No expertise records found.</div>');
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Expertise Area</th>
                                <th>Skill Level</th>
                                <th>Years of Experience</th>
                                <th>Certification</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            data.forEach(function(expertise, index) {
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><strong>${expertise.expertise_area || expertise.Expertise_area || 'N/A'}</strong></td>
                        <td><span class="badge ${getSkillLevelBadgeClass(expertise.skill_level || expertise.Skill_level)}">${expertise.skill_level || expertise.Skill_level || 'N/A'}</span></td>
                        <td>${expertise.years_of_experience || expertise.Years_of_experience || 'N/A'} years</td>
                        <td>${expertise.certification || expertise.Certification || '-'}</td>
                        <td>${expertise.description ? (expertise.description.substring(0, 50) + '...') : (expertise.Description ? (expertise.Description.substring(0, 50) + '...') : '-')}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#expertiseContent').html(html);
        }

        function getSkillLevelBadgeClass(level) {
            switch(level) {
                case 'Master':
                case 'Expert': return 'bg-success';
                case 'Advanced': return 'bg-primary';
                case 'Intermediate': return 'bg-info';
                case 'Beginner': return 'bg-warning';
                default: return 'bg-secondary';
            }
        }

        function loadBankAccountDetails() {
            $.ajax({
                url: '../../WebService.asmx/GetBankDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        // Handle if result is an array
                        var data = Array.isArray(result) && result.length > 0 ? result[0] : result;
                        
                        if (data && Object.keys(data).length > 0) {
                            displayBankAccountDetails(data);
                        } else {
                            $('#bankAccountContent').html('<div class="alert alert-warning">No bank account details available.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading bank account details:', e);
                        $('#bankAccountContent').html('<div class="alert alert-danger">Error loading bank account details.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load bank account details:', error);
                    $('#bankAccountContent').html('<div class="alert alert-danger">Failed to load bank account details.</div>');
                }
            });
        }

        function displayBankAccountDetails(data) {
            var html = '<div class="personal-details-grid">';
            
            html += createDetailRowGrid('fa-user-circle', 'Beneficiary Name', data.beneficiary_name || data.Beneficiary_name);
            html += createDetailRowGrid('fa-credit-card', 'Bank Account Number', maskAccountNumber(data.bank_account_no || data.Bank_account_no));
            html += createDetailRowGrid('fa-list-alt', 'Account Type', data.account_type || data.Account_type);
            html += createDetailRowGrid('fa-code', 'IFSC Code', data.ifsc_code || data.Ifsc_code);
            html += createDetailRowGrid('fa-university', 'Bank Name', data.bank_name || data.Bank_name);
            html += createDetailRowGrid('fa-map-marker-alt', 'Branch Name', data.branch_name || data.Branch_name);
            
            html += '</div>';
            
            $('#bankAccountContent').html(html);
        }

        function maskAccountNumber(accountNo) {
            if (!accountNo) return null;
            var acctStr = accountNo.toString();
            if (acctStr.length > 4) {
                var lastFour = acctStr.slice(-4);
                var masked = 'X'.repeat(acctStr.length - 4) + lastFour;
                return masked;
            }
            return accountNo;
        }

        function loadEducationDetails() {
            $.ajax({
                url: '../../WebService.asmx/GetEducationDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayEducationDetails(result);
                        } else {
                            $('#educationDetailsContent').html('<div class="alert alert-warning">No education details added yet.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading education details:', e);
                        $('#educationDetailsContent').html('<div class="alert alert-danger">Error loading education details.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load education details:', error);
                    $('#educationDetailsContent').html('<div class="alert alert-danger">Failed to load education details.</div>');
                }
            });
        }

        function displayEducationDetails(data) {
            if (data.length === 0) {
                $('#totalEducation').text('0');
                $('#educationDetailsContent').html('<div class="alert alert-warning">No education records found.</div>');
                return;
            }

            // Update stat counter
            $('#totalEducation').text(data.length);

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Program</th>
                                <th>Degree</th>
                                <th>Specialization</th>
                                <th>University</th>
                                <th>Period</th>
                                <th>Percentage/CGPA</th>
                                <th>Division</th>
                                <th>Mode</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            data.forEach(function(edu, index) {
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><span class="badge bg-primary">${edu.program || 'N/A'}</span></td>
                        <td>${edu.degree || 'N/A'}</td>
                        <td>${edu.specialization || 'N/A'}</td>
                        <td>${edu.university || 'N/A'}</td>
                        <td>${formatDate(edu.start_date) || ''} to ${formatDate(edu.end_date) || ''}</td>
                        <td>${edu.percentage_cgpa || 'N/A'}</td>
                        <td><span class="badge ${getDivisionBadgeClass(edu.percentage_division)}">${edu.percentage_division || 'N/A'}</span></td>
                        <td>${edu.mode || 'N/A'}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#educationDetailsContent').html(html);
        }

        function getDivisionBadgeClass(division) {
            switch(division) {
                case 'First Class':
                case 'Distinction': return 'bg-success';
                case 'Second Class': return 'bg-info';
                case 'Third Class': return 'bg-warning';
                default: return 'bg-secondary';
            }
        }

        function loadContactDetails() {
            $.ajax({
                url: '../../WebService.asmx/GetContactDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        // Handle if result is an array
                        var data = Array.isArray(result) && result.length > 0 ? result[0] : result;
                        
                        if (data && Object.keys(data).length > 0) {
                            displayContactDetails(data);
                        } else {
                            $('#contactDetailsContent').html('<div class="alert alert-warning">No contact details available.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading contact details:', e);
                        $('#contactDetailsContent').html('<div class="alert alert-danger">Error loading contact details.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load contact details:', error);
                    $('#contactDetailsContent').html('<div class="alert alert-danger">Failed to load contact details.</div>');
                }
            });
        }

        function displayContactDetails(data) {
            var html = '';
            
            // Permanent Address Section
            html += '<h6 class="section-subtitle"><i class="fas fa-home me-2"></i>Permanent Address</h6>';
            html += '<div class="personal-details-grid">';
            html += createDetailRowGrid('fa-road', 'Address Line 1', data.address_line_1 || data.Address_line_1);
            html += createDetailRowGrid('fa-road', 'Address Line 2', data.address_line_2 || data.Address_line_2);
            html += createDetailRowGrid('fa-city', 'City', data.permanent_city || data.pcity || data.Permanent_city);
            html += createDetailRowGrid('fa-map', 'State', data.permanent_state || data.pstate || data.Permanent_state);
            html += createDetailRowGrid('fa-flag', 'Country', data.permanent_country || data.pcountry || data.Permanent_country);
            html += createDetailRowGrid('fa-map-marked-alt', 'Full Address', data.permanent_address || data.Permanent_address);
            html += '</div>';
            
            // Residing Address Section
            html += '<h6 class="section-subtitle mt-4"><i class="fas fa-building me-2"></i>Residing Address</h6>';
            html += '<div class="personal-details-grid">';
            html += createDetailRowGrid('fa-road', 'Address Line 1', data.residing_address_line_1 || data.Residing_address_line_1);
            html += createDetailRowGrid('fa-road', 'Address Line 2', data.residing_address_line_2 || data.Residing_address_line_2);
            html += createDetailRowGrid('fa-city', 'City', data.residing_city || data.rcity || data.Residing_city);
            html += createDetailRowGrid('fa-map', 'State', data.residing_state || data.rstate || data.Residing_state);
            html += createDetailRowGrid('fa-flag', 'Country', data.residing_county || data.rcountry || data.Residing_county);
            html += createDetailRowGrid('fa-map-marked-alt', 'Full Address', data.residing_address || data.Residing_address);
            html += '</div>';
            
            $('#contactDetailsContent').html(html);
        }

        function loadPersonalDetails() {
            $.ajax({
                url: '../../WebService.asmx/GetPersonalDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        // Handle if result is an array
                        var data = Array.isArray(result) && result.length > 0 ? result[0] : result;
                        
                        if (data && Object.keys(data).length > 0) {
                            displayPersonalDetails(data);
                        } else {
                            $('#personalDetailsContent').html('<div class="alert alert-warning">No personal details available.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading personal details:', e);
                        $('#personalDetailsContent').html('<div class="alert alert-danger">Error loading personal details.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load personal details:', error);
                    $('#personalDetailsContent').html('<div class="alert alert-danger">Failed to load personal details.</div>');
                }
            });
        }

        function displayPersonalDetails(data) {
            var html = '';
            
            // Profile Image if available
            if (data.filename || data.profile_file_name) {
                var imagePath = data.filepath || data.profile_file_path || ('../../UserUploadDocumnet/Profile_Document/' + (data.filename || data.profile_file_name));
                html += `
                    <div class="profile-image-display" style="display:none;">
                        <img src="${imagePath}" alt="Profile Photo" onerror="this.src='data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'150\' height=\'150\' viewBox=\'0 0 150 150\'%3E%3Crect width=\'150\' height=\'150\' fill=\'%23f8f9fa\'/%3E%3Ctext x=\'75\' y=\'75\' text-anchor=\'middle\' dy=\'.3em\' fill=\'%236c757d\' font-size=\'14\'%3ENo Photo%3C/text%3E%3C/svg%3E'">
                    </div>
                `;
            }
            
            // Two-column grid layout from First Name to Alternative Email
            html += '<div class="personal-details-grid">';
            
            // Basic Information
            html += createDetailRowGrid('fa-user', 'First Name', data.first_name || data.First_name);
            html += createDetailRowGrid('fa-user', 'Middle Name', data.middle_name || data.Middle_name);
            html += createDetailRowGrid('fa-user', 'Last Name', data.last_name || data.Last_name);
            html += createDetailRowGrid('fa-id-card', 'Full Name', data.full_name || data.Full_name);
            html += createDetailRowGrid('fa-calendar', 'Date of Birth', formatDateForDisplay(data.dob || data.DOB));
            html += createDetailRowGrid('fa-venus-mars', 'Gender', getGenderText(data.gender || data.Gender));
            
            // Birth & Identity
            html += createDetailRowGrid('fa-map-marker-alt', 'Place of Birth', data.place_of_birth || data.Place_of_birth);
            html += createDetailRowGrid('fa-flag', 'Nationality', data.nationality_name || data.nationality || data.Nationality);
            html += createDetailRowGrid('fa-list', 'Category', data.category_id || data.Category_id);
            
            // Contact Information
            html += createDetailRowGrid('fa-phone', 'Mobile Number', data.mobile_no || data.Mobile_no);
            html += createDetailRowGrid('fa-phone-alt', 'Alternative Mobile', data.alternet_mob_no || data.Alternet_mob_no);
            html += createDetailRowGrid('fa-user-shield', 'Emergency Contact Name', data.emergency_contact_name || data.Emergency_contact_name);
            html += createDetailRowGrid('fa-phone-square', 'Emergency Contact Number', data.emergency_contact_no || data.Emergency_contact_no);
            
            // Email Information
            html += createDetailRowGrid('fa-envelope', 'Personal Email', data.personal_email_id || data.Personal_email_id);
            html += createDetailRowGrid('fa-envelope-open', 'Alternative Email', data.alternet_email_id || data.Alternet_email_id);
            
            html += '</div>'; // Close grid
            
            // Profile Information - Keep full width for text areas
            html += '<div class="personal-details-list">';
            html += createDetailRow('fa-file-alt', 'User Profile Details', data.user_profile_dtl || data.User_profile_dtl, true);
            html += createDetailRow('fa-graduation-cap', 'Education & Work Profile', data.edu_work_profile || data.Edu_work_profile, true);
            html += '</div>';
            
            $('#personalDetailsContent').html(html);
        }

        function createDetailRow(icon, label, value, isTextArea) {
            var displayValue = value || '<span class="text-muted">Not provided</span>';
            var emptyClass = !value ? 'empty' : '';
            
            if (isTextArea && value) {
                // For textarea content, show full text with line breaks
                displayValue = value.replace(/\n/g, '<br>');
            }
            
            return `
                <div class="detail-row">
                    <div class="detail-label">
                        <i class="fas ${icon}"></i>
                        ${label}
                    </div>
                    <div class="detail-value ${emptyClass}">
                        ${displayValue}
                    </div>
                </div>
            `;
        }

        function createDetailRowGrid(icon, label, value) {
            var displayValue = value || '<span class="text-muted">Not provided</span>';
            var emptyClass = !value ? 'empty' : '';
            
            return `
                <div class="detail-row-grid">
                    <div class="detail-label-grid">
                        <i class="fas ${icon}"></i>
                        ${label}
                    </div>
                    <div class="detail-value-grid ${emptyClass}">
                        ${displayValue}
                    </div>
                </div>
            `;
        }

        function getGenderText(gender) {
            switch(gender) {
                case 'M': return 'Male';
                case 'F': return 'Female';
                case 'O': return 'Other';
                default: return gender || 'Not specified';
            }
        }

        function formatDateForDisplay(dateString) {
            if (!dateString) return null;
            try {
                var date = new Date(dateString);
                return date.toLocaleDateString('en-US', { 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                });
            } catch (e) {
                return dateString;
            }
        }

        function loadExperienceSummary() {
            $.ajax({
                url: '../../WebService.asmx/GetDesignationSaveDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayExperienceSummary(result[0]);
                        } else {
                            $('#experienceSummaryContent').html('<div class="alert alert-warning">No experience summary data available.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading experience summary:', e);
                        $('#experienceSummaryContent').html('<div class="alert alert-danger">Error loading data.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load experience summary:', error);
                    $('#experienceSummaryContent').html('<div class="alert alert-danger">Failed to load experience summary.</div>');
                }
            });
        }

        function displayExperienceSummary(data) {
            var totalYears = parseInt(data.total_experience_years || 0);
            var totalMonths = parseInt(data.total_experience_months || 0);
            var totalExp = totalYears + (totalMonths / 12);
            
            $('#totalExperience').text(totalExp.toFixed(1));
            
            var html = `
                <div class="row">
                    <div class="col-md-6">
                        <div class="summary-row">
                            <div class="summary-label">Department</div>
                            <div class="summary-value">${data.dept_name || data.dept_code || 'N/A'}</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="summary-row">
                            <div class="summary-label">Designation</div>
                            <div class="summary-value">${data.designation_name || data.designation_code || 'N/A'}</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="summary-row">
                            <div class="summary-label">Total Experience</div>
                            <div class="summary-value">${totalYears} Years ${totalMonths} Months</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="summary-row">
                            <div class="summary-label">Teaching Experience</div>
                            <div class="summary-value">${data.total_teaching_years || 0} Years ${data.total_teaching_months || 0} Months</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="summary-row">
                            <div class="summary-label">Industry Experience</div>
                            <div class="summary-value">${data.total_industry_years || 0} Years ${data.total_industry_months || 0} Months</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="summary-row">
                            <div class="summary-label">Research Experience</div>
                            <div class="summary-value">${data.total_research_years || 0} Years ${data.total_research_months || 0} Months</div>
                        </div>
                    </div>
                </div>
            `;
            
            $('#experienceSummaryContent').html(html);
        }

        function loadPublications() {
            $.ajax({
                url: '../../WebService.asmx/GetPublicationsDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ yearcode: 'NoData' }),
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayPublications(result); // displayPublications will update the count
                        } else {
                            $('#totalPublications').text('0');
                            $('#publicationsContent').html('<div class="alert alert-warning">No publications added yet.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading publications:', e);
                        $('#publicationsContent').html('<div class="alert alert-danger">Error loading publications.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load publications:', error);
                    $('#publicationsContent').html('<div class="alert alert-danger">Failed to load publications.</div>');
                }
            });
        }

        function displayPublications(data) {
            // Filter by year if year filter is applied
            var filteredData = data;
            if (currentSelectedYear) {
                var selectedYearNum = currentSelectedYear.split('-')[0]; // Extract first part of year (e.g., "2024" from "2024-2025")
                
                filteredData = data.filter(function(pub) {
                    // Try to match year in year field, yearcode, or publication_date
                    var pubYear = pub.year || pub.yearcode || pub.year_code || '';
                    var pubDate = pub.publication_date || pub.date || '';
                    
                    // Check if year field matches exactly
                    if (pubYear && pubYear.toString() === currentSelectedYear) {
                        return true;
                    }
                    
                    // Check if year field matches the first part (e.g., 2024)
                    if (pubYear && pubYear.toString() === selectedYearNum) {
                        return true;
                    }
                    
                    // Extract year from publication date
                    if (pubDate) {
                        var dateYearMatch = pubDate.toString().match(/\d{4}/);
                        if (dateYearMatch && dateYearMatch[0] === selectedYearNum) {
                            return true;
                        }
                    }
                    
                    return false;
                });
            }
            
            if (filteredData.length === 0) {
                $('#totalPublications').text('0');
                $('#publicationsContent').html('<div class="alert alert-warning">No publications found for selected year.</div>');
                return;
            }
            
            // Update count
            $('#totalPublications').text(filteredData.length);

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Year</th>
                                <th>Type</th>
                                <th>Title</th>
                                <th>Journal/Book Name</th>
                                <th>Authorship</th>
                                <th>Publication Date</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            filteredData.forEach(function(pub, index) {
                // Extract year from publication
                var year = pub.year || pub.yearcode || pub.year_code || '';
                if (!year && pub.publication_date) {
                    var dateMatch = pub.publication_date.toString().match(/\d{4}/);
                    year = dateMatch ? dateMatch[0] : '';
                }
                
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><span class="badge bg-info">${year || 'N/A'}</span></td>
                        <td><span class="badge bg-primary">${pub.type_name || pub.publication_type || 'N/A'}</span></td>
                        <td><strong>${pub.title_of_paper || pub.title || 'N/A'}</strong></td>
                        <td>${pub.name_of_journal || pub.journal_book_name || 'N/A'}</td>
                        <td>${pub.authorship || 'N/A'}</td>
                        <td>${formatDateForDisplay(pub.publication_date) || 'N/A'}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#publicationsContent').html(html);
        }

        function loadConferences() {
            $.ajax({
                url: '../../WebService.asmx/GetConferencesDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ yearcode: 'NoData' }),
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayConferences(result); // displayConferences will update the count
                        } else {
                            $('#totalConferences').text('0');
                            $('#conferencesContent').html('<div class="alert alert-warning">No conferences added yet.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading conferences:', e);
                        $('#conferencesContent').html('<div class="alert alert-danger">Error loading conferences.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load conferences:', error);
                    $('#conferencesContent').html('<div class="alert alert-danger">Failed to load conferences.</div>');
                }
            });
        }

        function displayConferences(data) {
            // Filter by year if year filter is applied
            var filteredData = data;
            if (currentSelectedYear) {
                filteredData = data.filter(function(conf) {
                    // Try to match year in date fields or year field
                    var confDate = conf.start_date || conf.date || conf.end_date || '';
                    var confYear = conf.year || conf.yearcode || conf.year_code || '';
                    
                    // Check if date contains the year
                    if (confDate && confDate.toString().indexOf(currentSelectedYear.split('-')[0]) !== -1) {
                        return true;
                    }
                    
                    // Check if year field matches
                    if (confYear && confYear === currentSelectedYear) {
                        return true;
                    }
                    
                    return false;
                });
            }
            
            if (filteredData.length === 0) {
                $('#conferencesContent').html('<div class="alert alert-warning">No conferences found for selected year.</div>');
                return;
            }
            
            // Update count
            $('#totalConferences').text(filteredData.length);

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Type</th>
                                <th>Title of Research</th>
                                <th>Conference Name</th>
                                <th>Scope</th>
                                <th>Authorship</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            filteredData.forEach(function(conf, index) {
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><span class="badge bg-info">${conf.type_name || conf.type || 'N/A'}</span></td>
                        <td>${conf.title || conf.title_of_research || 'N/A'}</td>
                        <td>${conf.name_of_conference || 'N/A'}</td>
                        <td><span class="badge ${conf.conferenceType === 'International' ? 'bg-success' : 'bg-warning'}">${conf.conferenceType || 'N/A'}</span></td>
                        <td>${conf.authorship || 'N/A'}</td>
                        <td>${conf.start_date || 'N/A'}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#conferencesContent').html(html);
        }

        function loadResearchProjects() {
            $.ajax({
                url: '../../WebService.asmx/GetResearchDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ yearcode: 'NoData' }), // Use year filter
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            $('#totalResearch').text(result.length);
                            displayResearchProjects(result);
                        } else {
                            $('#totalResearch').text('0');
                            $('#researchContent').html('<div class="alert alert-warning">No research projects added yet.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading research projects:', e);
                        $('#researchContent').html('<div class="alert alert-danger">Error loading research projects.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load research projects:', error);
                    $('#researchContent').html('<div class="alert alert-danger">Failed to load research projects.</div>');
                }
            });
        }

        function displayResearchProjects(data) {
            if (data.length === 0) {
                $('#researchContent').html('<div class="alert alert-warning">No research projects found.</div>');
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Type</th>
                                <th>Title</th>
                                <th>Status</th>
                                <th>Funding Agency</th>
                                <th>Duration</th>
                                <th>Period</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            data.forEach(function(research, index) {
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td><span class="badge bg-warning">${research.type_name || research.typecode || 'N/A'}</span></td>
                        <td>${research.title || 'N/A'}</td>
                        <td><span class="badge ${getStatusBadgeClass(research.status)}">${research.status || 'N/A'}</span></td>
                        <td>${research.funding_agency || 'N/A'}</td>
                        <td>${research.duration || 'N/A'}</td>
                        <td>${research.start_date || ''} to ${research.end_date || ''}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#researchContent').html(html);
        }

        function loadOtherResearchActivities() {
            $.ajax({
                url: '../../WebService.asmx/GetOtherResearchActivitiesDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayOtherResearchActivities(result);
                        } else {
                            $('#otherResearchContent').html('<div class="alert alert-warning">No other research activities added yet.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading other research activities:', e);
                        $('#otherResearchContent').html('<div class="alert alert-danger">Error loading data.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load other research activities:', error);
                    $('#otherResearchContent').html('<div class="alert alert-danger">Failed to load data.</div>');
                }
            });
        }

        function displayOtherResearchActivities(data) {
            // Filter by year if year filter is applied
            var filteredData = data;
            if (currentSelectedYear) {
                filteredData = data.filter(function(activity) {
                    // Check if year field matches
                    var activityYear = activity.year || activity.yearcode || activity.year_code || '';
                    
                    if (activityYear && activityYear === currentSelectedYear) {
                        return true;
                    }
                    
                    // Also check date field
                    var activityDate = activity.date || '';
                    if (activityDate && activityDate.toString().indexOf(currentSelectedYear.split('-')[0]) !== -1) {
                        return true;
                    }
                    
                    return false;
                });
            }
            
            if (filteredData.length === 0) {
                $('#totalActivities').text('0');
                $('#otherResearchContent').html('<div class="alert alert-warning">No other research activities found for selected year.</div>');
                return;
            }

            // Update stat counter
            $('#totalActivities').text(filteredData.length);

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Title</th>
                                <th>Type</th>
                                <th>Description</th>
                                <th>Hours</th>
                                <th>Date</th>
                                <th>Year</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            filteredData.forEach(function(activity, index) {
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${activity.title || 'N/A'}</td>
                        <td><span class="badge bg-danger">${activity.type_name || activity.type_code || 'N/A'}</span></td>
                        <td>${activity.other_research_activities ? (activity.other_research_activities.substring(0, 50) + '...') : 'N/A'}</td>
                        <td>${activity.total_hours || 'N/A'}</td>
                        <td>${activity.date || 'N/A'}</td>
                        <td>${activity.year_name || activity.year || 'N/A'}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#otherResearchContent').html(html);
        }

        function loadExperienceDetails() {
            $.ajax({
                url: '../../WebService.asmx/GetExperienceDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            displayExperienceDetails(result);
                        } else {
                            $('#experienceDetailsContent').html('<div class="alert alert-warning">No experience details added yet.</div>');
                        }
                    } catch (e) {
                        console.error('Error loading experience details:', e);
                        $('#experienceDetailsContent').html('<div class="alert alert-danger">Error loading data.</div>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load experience details:', error);
                    $('#experienceDetailsContent').html('<div class="alert alert-danger">Failed to load data.</div>');
                }
            });
        }

        function displayExperienceDetails(data) {
            // Filter by year if year filter is applied
            var filteredData = data;
            if (currentSelectedYear) {
                filteredData = data.filter(function(exp) {
                    // Check if date range includes the selected year
                    var startDate = exp.start_date || '';
                    var endDate = exp.end_date || '';
                    var year = exp.year || exp.yearcode || exp.year_code || '';
                    
                    // Check if year field matches
                    if (year && year === currentSelectedYear) {
                        return true;
                    }
                    
                    // Check if date range includes the selected year
                    var selectedYearNum = parseInt(currentSelectedYear.split('-')[0]);
                    
                    if (startDate) {
                        var startYear = new Date(startDate).getFullYear();
                        var endYear = endDate ? new Date(endDate).getFullYear() : new Date().getFullYear();
                        
                        if (selectedYearNum >= startYear && selectedYearNum <= endYear) {
                            return true;
                        }
                    }
                    
                    return false;
                });
            }
            
            if (filteredData.length === 0) {
                $('#experienceDetailsContent').html('<div class="alert alert-warning">No experience details found for selected year.</div>');
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Organization</th>
                                <th>Designation</th>
                                <th>Type</th>
                                <th>Period</th>
                                <th>Mode</th>
                                <th>Duration (Months)</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            filteredData.forEach(function(exp, index) {
                html += `
                    <tr>
                        <td>${index + 1}</td>
                        <td>${exp.organization_name || 'N/A'}</td>
                        <td>${exp.designation || 'N/A'}</td>
                        <td><span class="badge ${getExperienceTypeBadge(exp.experience_type)}">${exp.experience_type || 'N/A'}</span></td>
                        <td>${formatDate(exp.start_date) || 'N/A'} to ${exp.end_date ? formatDate(exp.end_date) : 'Present'}</td>
                        <td>${exp.mode_of_experience || 'N/A'}</td>
                        <td>${exp.total_year_months_counts || 'N/A'}</td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            $('#experienceDetailsContent').html(html);
        }

        function getStatusBadgeClass(status) {
            switch (status) {
                case 'Completed': return 'bg-success';
                case 'In Progress': return 'bg-primary';
                case 'Approved': return 'bg-info';
                case 'Under Review': return 'bg-warning';
                default: return 'bg-secondary';
            }
        }

        function getExperienceTypeBadge(type) {
            switch (type) {
                case 'Teaching': return 'bg-success';
                case 'Industry': return 'bg-primary';
                case 'Research': return 'bg-info';
                default: return 'bg-secondary';
            }
        }

        function formatDate(dateString) {
            if (!dateString) return '';
            try {
                var date = new Date(dateString);
                return date.toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
            } catch (e) {
                return dateString;
            }
        }

        function showMessage(message, type) {
            var alertClass = type === 'success' ? 'alert-success' : 
                            type === 'error' ? 'alert-danger' : 'alert-info';
            
            var html = `
                <div class="alert ${alertClass} alert-dismissible fade show" 
                     style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            `;
            
            $('body').append(html);
            
            setTimeout(function() {
                $('.alert').fadeOut();
            }, 3000);
        }
    </script>
</asp:Content>

