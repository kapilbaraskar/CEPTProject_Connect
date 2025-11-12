<%@ Page Title="Publication" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="Publication.aspx.cs" Inherits="Admin_Profile_Publication" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
  <!-- SheetJS Library for Excel Import/Export -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
  <div class="personal-details-container">
    <div class="tab-content">
        <div class="tab-pane fade show active" id="publication-tab" role="tabpanel">
            
            <!-- Main Header -->
            <div class="card mb-4">
                <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                        <i class="fas fa-book me-2" style="font-size: 1rem;"></i>
                        Publications
                    </h5>
                </div>
            </div>
            <!-- Year Filter -->
                <div class="card mb-4" style="display:none;">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-calendar-alt me-2" style="font-size: 0.85rem;"></i>
                            Filter by Year
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <label class="form-label">Select Year</label>
                                <select id="yearFilter" name="yearFilter" class="form-select">
                                    <option value="" selected disabled>Select Year</option>
                                </select>
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="button" id="btnLoadData" class="btn btn-primary btn-sm">
                                    <i class="fas fa-search me-2"></i>
                                    Load Data
                                </button>
                            </div>
                            <div class="col-md-4 d-flex align-items-end" style="display:none;">
                                <button type="button" id="btnLoadCurrentYear" class="btn btn-success btn-sm">
                                    <i class="fas fa-calendar-check me-2"></i>
                                    Load Current Year
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            <!-- All Years Publications History Section -->
            <div class="card mb-4" id="allYearsSection">
                <div class="card-header" style="background-color:#e7f3ff;border-color: #007bff;">
                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: #007bff;">
                            <i class="fas fa-database me-2" style="font-size: 0.85rem;"></i>
                            All Years Publications History
                            <span id="allYearsRecordsCount" class="badge bg-success ms-2" style="font-size: 0.75rem;">0</span>
                        </h5>
                        <div>
                            <button type="button" id="btnLoadAllYears" class="btn btn-success btn-sm">
                                <i class="fas fa-sync me-2"></i>
                                Load All Years Data
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div id="allYearsPublicationsList">
                        <div class="text-center text-muted py-4">
                            <i class="fas fa-database fa-2x mb-3"></i>
                            <p>Click "Load All Years Data" button to view complete publications history from all academic years.</p>
                        </div>
                    </div>
                    <!-- All Years Pagination Controls -->
                    <div id="allYearsPaginationControls" class="d-flex justify-content-between align-items-center mt-3" style="display: none !important;">
                        <div class="pagination-info" style="font-size: 0.85rem; color: #6c757d;">
                            Showing <span id="allYearsShowingFrom">0</span> to <span id="allYearsShowingTo">0</span> of <span id="allYearsTotalRecords">0</span> records
                        </div>
                        <nav aria-label="All years pagination">
                            <ul class="pagination pagination-sm mb-0" id="allYearsPaginationList">
                                <!-- Pagination buttons will be inserted here -->
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
           

            <!-- Add New Publication Form -->
            <div class="card mb-4" id="publicationForm">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                        Add New Publication
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label required">Publication Type</label>
                            <select id="publication_type" name="publication_type" class="form-select" required>
                                <option value="" selected disabled>Select Publication Type</option>
                                <%--<option value="Journal Article">Journal Article</option>
                                <option value="Conference Paper">Conference Paper</option>
                                <option value="Book Chapter">Book Chapter</option>
                                <option value="Book">Book</option>
                                <option value="Patent">Patent</option>
                                <option value="Technical Report">Technical Report</option>--%>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Name of Journal/Conference</label>
                            <input type="text" id="journal_conference_name" name="journal_conference_name" class="form-control" placeholder="Enter journal or conference name" required>
                        </div>
                         <div class="col-md-12">
                             <label class="form-label required">Title of Research</label>
                             <textarea id="title_of_research" name="title_of_research" class="form-control" rows="3" placeholder="Enter the title of your research" required maxlength="500"></textarea>
                             <div class="text-end mt-1">
                                 <small class="text-muted">
                                     <span id="charCount">0</span> characters, <span id="wordCount">0</span> words (Max: 500 characters)
                                 </small>
                             </div>
                         </div>
                        <div class="col-md-6">
                            <label class="form-label required">Scope</label>
                            <select id="scope" name="scope" class="form-select" required>
                                <option value="" selected disabled>Select Scope</option>
                                <option value="National">National</option>
                                <option value="International">International</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Impact Factor of Journal</label>
                            <input type="text" id="impact_factor" name="impact_factor" class="form-control" placeholder="Enter impact factor (if applicable)">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Authorship</label>
                            <select id="authorship" name="authorship" class="form-select" required>
                                <option value="" selected disabled>Select Authorship</option>
                                <option value="First Author">First Author</option>
                                <option value="Second Author">Second Author</option>
                                <option value="Third Author">Third Author</option>
                                <option value="Corresponding Author">Corresponding Author</option>
                                <option value="Co-Author">Co-Author</option>
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label required">Author Details</label>
                            <textarea id="author_details" name="author_details" class="form-control" rows="3" placeholder="Enter detailed author information including names, affiliations, and contact details" required maxlength="1000"></textarea>
                            <div class="text-end mt-1">
                                <small class="text-muted">
                                    <span id="authorCharCount">0</span> characters (Max: 1000 characters)
                                </small>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Month of Publication</label>
                            <select id="month_of_publication" name="month_of_publication" class="form-select" required>
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
                        <div class="col-md-6">
                            <label class="form-label required">Year of Publication</label>
                            <select id="year_of_publication" name="year_of_publication" class="form-select" required>
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
                            <label class="form-label required">Whether submitted to University</label>
                            <select id="submitted_to_university" name="submitted_to_university" class="form-select" required>
                                <option value="" selected disabled>Select Status</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>
                                <%--<option value="Under Review">Under Review</option>
                                <option value="Accepted">Accepted</option>
                                <option value="Rejected">Rejected</option>--%>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Publication Status</label>
                            <select id="publication_status" name="publication_status" class="form-select" required>
                                <option value="" selected disabled>Select Publication Status</option>
                                
                                <option value="Accepted">Accepted</option>
                                <option value="Under Review">Under Review</option>
                                
                                <option value="In Progress">In Progress</option>
                                <option value="Rejected">Rejected</option>
                            </select>
                        </div>
                        <div class="col-md-6" style="display:none;">
                            <label class="form-label">Total Hours Spent</label>
                            <input type="number" id="total_hours" name="total_hours" class="form-control" placeholder="Enter total hours spent on research" min="0" step="0.5" value="0">
                            <small class="text-muted">Enter hours spent on this research work (e.g., 120.5)</small>
                        </div>
                        <div class="col-md-12" style="padding-top: 15px;">
                            <button type="button" id="btnAddPublication" class="btn btn-primary btn-sm">
                                <i class="fas fa-plus me-2"></i>
                                Add Publication
                            </button>
                            <button type="button" id="btnUpdatePublication" class="btn btn-warning btn-sm" style="display: none;">
                                <i class="fas fa-edit me-2"></i>
                                Update Publication
                            </button>
                            <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                <i class="fas fa-times me-2"></i>
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>

             <!-- Excel Import/Export Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#e3f2fd;border-color: #90caf9;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-file-excel me-2" style="font-size: 0.85rem; color: #1e7e34;"></i>
                        Excel Import/Export
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <!-- Step 1: Download Template -->
                        <div class="col-md-6 mb-3">
                            <div class="excel-section" style="background-color: #e8f5e9; padding: 15px; border-radius: 8px; border: 1px solid #c8e6c9;">
                                <h6 style="color: #2e7d32; font-size: 13px; font-weight: 600; margin-bottom: 10px;">
                                    <i class="fas fa-download me-2"></i>Step 1: Download Excel Template
                                </h6>
                                <p style="font-size: 12px; color: #555; margin-bottom: 10px;">
                                    Download a pre-formatted Excel template with sample data and instructions.
                                </p>
                                <button type="button" id="btnDownloadExcel" class="btn btn-success btn-sm">
                                    <i class="fas fa-file-excel me-2"></i>
                                    Download Excel Template
                                </button>
                            </div>
                        </div>

                        <!-- Step 2: Upload Template -->
                        <div class="col-md-6 mb-3">
                            <div class="excel-section" style="background-color: #fff3e0; padding: 15px; border-radius: 8px; border: 1px solid #ffe0b2;">
                                <h6 style="color: #e65100; font-size: 13px; font-weight: 600; margin-bottom: 10px;">
                                    <i class="fas fa-upload me-2"></i>Step 2: Upload Filled Template
                                </h6>
                                <p style="font-size: 12px; color: #555; margin-bottom: 10px;">
                                    Upload your filled Excel file to import multiple publications at once.
                                </p>
                                <div class="d-flex gap-2 align-items-center">
                                    <input type="file" id="excelFileUpload" accept=".xlsx,.xls" class="form-control form-control-sm" style="max-width: 250px;">
                                    <button type="button" id="btnUploadExcel" class="btn btn-primary btn-sm">
                                        <i class="fas fa-cloud-upload-alt me-2"></i>
                                        Upload & Import
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Excel Preview Section (Hidden by default) -->
                    <div id="excelPreviewSection" style="display: none; margin-top: 20px;">
                        <div class="alert alert-info" style="font-size: 12px;">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Preview:</strong> Review the imported data below. Click "Confirm Import" to add all publications or "Cancel" to discard.
                        </div>
                        <div class="table-responsive" style="max-height: 400px; overflow-y: auto; border: 1px solid #dee2e6; border-radius: 6px;">
                            <table class="table table-sm table-bordered table-hover mb-0" id="excelPreviewTable">
                                <thead class="table-light" style="position: sticky; top: 0; z-index: 10;">
                                    <tr style="font-size: 11px;">
                                        <th>S.No</th>
                                        <th>Publication Type</th>
                                        <th>Journal/Conference</th>
                                        <th>Title</th>
                                        <th>Scope</th>
                                        <th>Impact Factor</th>
                                        <th>Authorship</th>
                                        <th>Author Details</th>
                                        <th>Month</th>
                                        <th>Year</th>
                                        <th>Submitted</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody id="excelPreviewBody" style="font-size: 11px;">
                                </tbody>
                            </table>
                        </div>
                        <div class="mt-3 d-flex gap-2">
                            <button type="button" id="btnConfirmImport" class="btn btn-success btn-sm">
                                <i class="fas fa-check me-2"></i>
                                Confirm Import (<span id="excelRecordCount">0</span> publications)
                            </button>
                            <button type="button" id="btnCancelImport" class="btn btn-secondary btn-sm">
                                <i class="fas fa-times me-2"></i>
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Publications Records List -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <div class="d-flex justify-content-between align-items-center flex-wrap">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                            Publications Records List
                            <span id="recordsCount" class="badge bg-primary ms-2" style="font-size: 0.75rem;">0</span>
                        </h5>
                        <div class="records-per-page-container">
                            <i class="fas fa-table me-2"></i>
                            <label class="records-per-page-label mb-0 me-2">Show</label>
                            <select id="recordsPerPage" class="form-select form-select-sm records-per-page-select">
                                <option value="5">5</option>
                                <option value="10" selected>10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select>
                            <label class="records-per-page-label mb-0 ms-2">per page</label>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div id="publicationsRecordsList">
                        <div class="text-center text-muted py-4">
                            <i class="fas fa-book fa-2x mb-3"></i>
                            <p>No publications added yet. Add your first publication above.</p>
                        </div>
                    </div>
                    <!-- Pagination Controls -->
                    <div id="paginationControls" class="d-flex justify-content-between align-items-center mt-3" style="display: none !important;">
                        <div class="pagination-info" style="font-size: 0.85rem; color: #6c757d;">
                            Showing <span id="showingFrom">0</span> to  <span id="showingTo"> 0 </span> of <span id="totalRecords">0</span> records
                        </div>
                        <nav aria-label="Publications pagination">
                            <ul class="pagination pagination-sm mb-0" id="paginationList">
                                <!-- Pagination buttons will be inserted here -->
                            </ul>
                        </nav>
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

    /* Records Per Page Styles */
    .records-per-page-container {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 6px 12px;
        background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
        border: 1px solid #dee2e6;
        border-radius: 6px;
        transition: all 0.3s ease;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
    }

    .records-per-page-container:hover {
        border-color: #007bff;
        box-shadow: 0 2px 6px rgba(0, 123, 255, 0.15);
    }

    .records-per-page-container i {
        color: #007bff;
        font-size: 0.9rem;
    }

    .records-per-page-label {
        font-size: 0.85rem;
        font-weight: 500;
        color: #495057;
        white-space: nowrap;
    }

    .records-per-page-select {
        width: auto;
        min-width: 70px;
        padding: 4px 32px 4px 10px;
        font-size: 0.85rem;
        font-weight: 600;
        color: #007bff;
        background-color: #fff;
        border: 1px solid #007bff;
        border-radius: 4px;
        cursor: pointer;
        transition: all 0.2s ease;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23007bff' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 8px center;
        background-size: 16px 12px;
    }

    .records-per-page-select:hover {
        background-color: #e7f3ff;
        border-color: #0056b3;
    }

    .records-per-page-select:focus {
        outline: none;
        border-color: #0056b3;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        background-color: #fff;
    }

    .records-per-page-select option {
        padding: 8px;
        font-size: 0.85rem;
    }

    /* Pagination Styles */
    .pagination {
        display: flex;
        padding-left: 0;
        list-style: none;
        margin: 0;
    }

    .pagination .page-item {
        margin: 0 2px;
    }

    .pagination .page-link {
        position: relative;
        display: block;
        padding: 0.375rem 0.75rem;
        margin-left: 0;
        line-height: 1.25;
        color: #007bff;
        background-color: #fff;
        border: 1px solid #dee2e6;
        border-radius: 0.25rem;
        cursor: pointer;
        font-size: 0.85rem;
        transition: all 0.2s ease;
    }

    .pagination .page-link:hover {
        z-index: 2;
        color: #0056b3;
        text-decoration: none;
        background-color: #e9ecef;
        border-color: #dee2e6;
    }

    .pagination .page-item.active .page-link {
        z-index: 3;
        color: #fff;
        background-color: #007bff;
        border-color: #007bff;
        font-weight: 600;
    }

    .pagination .page-item.disabled .page-link {
        color: #6c757d;
        pointer-events: none;
        cursor: not-allowed;
        background-color: #fff;
        border-color: #dee2e6;
        opacity: 0.5;
    }

    .pagination-info {
        display: flex;
        align-items: center;
        font-size: 0.85rem;
        color: #6c757d;
    }

    #paginationControls {
        padding-top: 15px;
        border-top: 1px solid #dee2e6;
        margin-top: 15px;
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

        #paginationControls {
            flex-direction: column;
            gap: 10px;
        }

        .pagination-info {
            order: 2;
            text-align: center;
        }

        .pagination {
            order: 1;
            justify-content: center;
            flex-wrap: wrap;
        }

        .card-header .d-flex {
            flex-direction: column;
            gap: 10px;
            align-items: flex-start !important;
        }

        .card-header .d-flex > div {
            width: 100%;
        }

        .records-per-page-container {
            width: 100%;
            justify-content: center;
            padding: 8px 12px;
        }

        .records-per-page-label {
            font-size: 0.8rem;
        }

        .records-per-page-select {
            min-width: 60px;
        }

        .card-header h5 {
            text-align: center;
            width: 100%;
        }
    }
</style>

<script>
    var publicationsRecords = [];
    var editingIndex = -1;
    var excelDataPreview = [];
    var publicationTypesMapping = {}; // Store TypeName -> TypeCode mapping
    
    // Pagination variables
    var currentPage = 1;
    var recordsPerPage = 10;
    
    // All Years section variables
    var allYearsRecords = [];
    var allYearsCurrentPage = 1;
    var allYearsRecordsPerPage = 10;

    $(document).ready(function () {
        // Records per page change handler
        $('#recordsPerPage').change(function() {
            recordsPerPage = parseInt($(this).val());
            currentPage = 1; // Reset to first page
            displayPublicationsRecords();
        });
        // Excel feature event handlers
        $('#btnDownloadExcel').click(function () {
            downloadExcelTemplate();
        });

        $('#btnUploadExcel').click(function () {
            var fileInput = document.getElementById('excelFileUpload');
            if (fileInput.files.length === 0) {
                showErrorMessage('Please select an Excel file first!');
                return;
            }
            uploadAndParseExcel(fileInput.files[0]);
        });

        $('#btnConfirmImport').click(function () {
            confirmExcelImport();
        });

        $('#btnCancelImport').click(function () {
            cancelExcelImport();
        });

        // Add publication button click handler
        $('#btnAddPublication').click(function () {
            addPublicationRecord();
        });

        // Update publication button click handler
        $('#btnUpdatePublication').click(function () {
            updatePublicationRecord();
        });

        // Cancel edit button click handler
        $('#btnCancelEdit').click(function () {
            cancelEdit();
        });

        // Save all button click handler
        $('#btnSaveAll').click(function () {
            saveAllPublicationsDetails();
        });

        // Previous button click handler
        $('#btnPrevious').click(function () {
            navigateToPreviousMenu();
        });

        // Next button click handler
        $('#btnNext').click(function () {
            navigateToNextMenu();
        });

        // Character and word count for title of research
        $('#title_of_research').on('input', function () {
            updateCharWordCount();
        });

        // Character count for author details
        $('#author_details').on('input', function () {
            updateAuthorCharCount();
        });

        // Load publication types for dropdown first, then load publications records
        loadPublicationsType();

        // Populate year filter dropdown
        populateYearFilterDropdown();

        // Auto-load all years data on page load
        setTimeout(function() {
            loadAllYearsPublications();
        }, 1000); // Small delay to ensure publication types are loaded first

        // Load Data button click handler
        $('#btnLoadData').click(function () {
            loadPublicationsByYear();
        });

        // Load All Years button click handler
        $('#btnLoadAllYears').click(function () {
            loadAllYearsPublications();
        });

        // Load Current Year button click handler
        $('#btnLoadCurrentYear').click(function () {
            loadCurrentYearPublications();
        });
    });

    function validateForm() {
        var isValid = true;
        var requiredFields = [
            'publication_type', 'journal_conference_name', 'title_of_research',
            'scope', 'authorship', 'month_of_publication',
            'year_of_publication', 'submitted_to_university', 'publication_status'
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

    function addPublicationRecord() {
        if (!validateForm()) {
            showErrorMessage('Please fill in all required fields');
            return;
        }

        var publicationData = {
            publication_type: $('#publication_type').val(),
            publication_type_name: $('#publication_type option:selected').text(),
            journal_conference_name: $('#journal_conference_name').val(),
            title_of_research: $('#title_of_research').val(),
            scope: $('#scope').val(),
            impact_factor: $('#impact_factor').val(),
            authorship: $('#authorship').val(),
            author_details: $('#author_details').val(),
            month_of_publication: $('#month_of_publication').val(),
            year_of_publication: $('#year_of_publication').val(),
            submitted_to_university: $('#submitted_to_university').val(),
            publication_status: $('#publication_status').val(),
            total_hours: $('#total_hours').val() || '0',
            id: Date.now()
        };

        publicationsRecords.push(publicationData);
        currentPage = 1; // Reset to first page when adding new record
        displayPublicationsRecords();
        clearForm();
        showTopRightMessage('Publication record added successfully!');
    }

    function updatePublicationRecord() {
        if (!validateForm()) {
            showErrorMessage('Please fill in all required fields');
            return;
        }

        var publicationData = {
            publication_type: $('#publication_type').val(),
            publication_type_name: $('#publication_type option:selected').text(),
            journal_conference_name: $('#journal_conference_name').val(),
            title_of_research: $('#title_of_research').val(),
            scope: $('#scope').val(),
            impact_factor: $('#impact_factor').val(),
            authorship: $('#authorship').val(),
            author_details: $('#author_details').val(),
            month_of_publication: $('#month_of_publication').val(),
            year_of_publication: $('#year_of_publication').val(),
            submitted_to_university: $('#submitted_to_university').val(),
            publication_status: $('#publication_status').val(),
            total_hours: $('#total_hours').val() || '0',
            id: publicationsRecords[editingIndex].id
        };

        publicationsRecords[editingIndex] = publicationData;
        displayPublicationsRecords();
        clearForm();
        cancelEdit();
        showTopRightMessage('Publication record updated successfully!');

        // Automatically save all publications after update
        saveAllPublicationsDetails();
    }

    function editPublicationRecord(index) {
        var record = publicationsRecords[index];

        // Fill form data
        $('#publication_type').val(record.publication_type);
        $('#journal_conference_name').val(record.journal_conference_name);
        $('#title_of_research').val(record.title_of_research);
        $('#scope').val(record.scope || record.scope);
        $('#impact_factor').val(record.impact_factor);
        $('#authorship').val(record.authorship);
        $('#author_details').val(record.author_details);
        $('#month_of_publication').val(record.month_of_publication);
        $('#year_of_publication').val(record.year_of_publication);
        $('#submitted_to_university').val(record.submitted_to_university);
        $('#publication_status').val(record.publication_status);
        $('#total_hours').val(record.total_hours || '0');

        // Show update buttons, hide add button
        editingIndex = index;
        $('#btnAddPublication').hide();
        $('#btnUpdatePublication').show();
        $('#btnCancelEdit').show();

        // Highlight the form section
        var formCard = $('#publication_type').closest('.card');
        formCard.addClass('border-primary');
        formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');

        // Remove highlight after 3 seconds
        setTimeout(function () {
            formCard.removeClass('border-primary');
            formCard.css('box-shadow', '');
        }, 3000);

        // Scroll to the edit section
        try {
            var publicationField = document.getElementById('publication_type');
            if (publicationField) {
                publicationField.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
        } catch (e) {
            try {
                $('html, body').animate({
                    scrollTop: $('#publication_type').offset().top - 100
                }, 1000);
            } catch (e2) {
                window.scrollTo(0, 0);
            }
        }

        showTopRightMessage('Publication record loaded for editing!');
    }

    function deletePublicationRecord(index) {
        if (confirm('Are you sure you want to delete this publication record?')) {
            publicationsRecords.splice(index, 1);
            
            // Adjust current page if needed
            var totalPages = Math.ceil(publicationsRecords.length / recordsPerPage);
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }
            if (publicationsRecords.length === 0) {
                currentPage = 1;
            }
            
            displayPublicationsRecords();
            showTopRightMessage('Publication record deleted successfully!');
        }
    }

    function cancelEdit() {
        editingIndex = -1;
        $('#btnAddPublication').show();
        $('#btnUpdatePublication').hide();
        $('#btnCancelEdit').hide();
        clearForm();
    }

    function clearForm() {
        $('#publication_type').val('');
        $('#journal_conference_name').val('');
        $('#title_of_research').val('');
        $('#scope').val('');
        $('#impact_factor').val('');
        $('#authorship').val('');
        $('#author_details').val('');
        $('#month_of_publication').val('');
        $('#year_of_publication').val('');
        $('#submitted_to_university').val('');
        $('#publication_status').val('');
        $('#total_hours').val('0');

        // Reset character and word count
        updateCharWordCount();
        updateAuthorCharCount();

        // Remove validation classes
        $('.form-control, .form-select').removeClass('is-invalid');
    }

    function updateCharWordCount() {
        var text = $('#title_of_research').val();
        var charCount = text.length;
        var wordCount = text.trim() === '' ? 0 : text.trim().split(/\s+/).length;

        $('#charCount').text(charCount);
        $('#wordCount').text(wordCount);

        // Change color based on character limit
        var charCountElement = $('#charCount');
        if (charCount > 450) {
            charCountElement.css('color', '#dc3545'); // Red for near limit
        } else if (charCount > 400) {
            charCountElement.css('color', '#ffc107'); // Yellow for warning
        } else {
            charCountElement.css('color', '#6c757d'); // Default muted color
        }
    }

    function updateAuthorCharCount() {
        var text = $('#author_details').val();
        var charCount = text.length;

        $('#authorCharCount').text(charCount);

        // Change color based on character limit
        var charCountElement = $('#authorCharCount');
        if (charCount > 900) {
            charCountElement.css('color', '#dc3545'); // Red for near limit
        } else if (charCount > 800) {
            charCountElement.css('color', '#ffc107'); // Yellow for warning
        } else {
            charCountElement.css('color', '#6c757d'); // Default muted color
        }
    }

    function displayPublicationsRecords() {
        var container = $('#publicationsRecordsList');
        var totalRecords = publicationsRecords.length;

        // Update records count badge
        $('#recordsCount').text(totalRecords);

        if (totalRecords === 0) {
            container.html(`
                <div class="text-center text-muted py-4">
                    <i class="fas fa-book fa-2x mb-3"></i>
                    <p>No publications added yet. Add your first publication above.</p>
                </div>
            `);
            $('#paginationControls').hide();
            return;
        }

        // Calculate pagination
        var totalPages = Math.ceil(totalRecords / recordsPerPage);
        var startIndex = (currentPage - 1) * recordsPerPage;
        var endIndex = Math.min(startIndex + recordsPerPage, totalRecords);

        // Get records for current page
        var pageRecords = publicationsRecords.slice(startIndex, endIndex);

        var html = `
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-light">
                        <tr>
                            <th style="font-size: 12px; font-weight: 600;">S.No</th>
                            <th style="font-size: 12px; font-weight: 600;">Publication Type</th>
                            <th style="font-size: 12px; font-weight: 600;">Title of Research</th>
                            <th style="font-size: 12px; font-weight: 600;">Journal/Conference</th>
                            <th style="font-size: 12px; font-weight: 600;">Scope</th>
                            <th style="font-size: 12px; font-weight: 600;">Authorship</th>
                            <th style="font-size: 12px; font-weight: 600;">Author Details</th>
                            <th style="font-size: 12px; font-weight: 600;">Publication Date</th>
                            <th style="font-size: 12px; font-weight: 600;">Submitted Status</th>
                            <th style="font-size: 12px; font-weight: 600;">Publication Status</th>
                            <th style="font-size: 12px; font-weight: 600; display:none;">Total Hours</th>
                            <th style="font-size: 12px; font-weight: 600;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        pageRecords.forEach(function (record, pageIndex) {
            var actualIndex = startIndex + pageIndex;
            html += `
                <tr>
                    <td style="font-size: 12px;">${actualIndex + 1}</td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getPublicationTypeBadgeClass(record.publication_type)}">${record.publication_type_name || record.publication_type}</span>
                    </td>
                    <td style="font-size: 12px;">${record.title_of_research ? (record.title_of_research.length > 30 ? record.title_of_research.substring(0, 30) + '...' : record.title_of_research) : '-'}</td>
                    <td style="font-size: 12px;">${record.journal_conference_name}</td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getScopeBadgeClass(record.scope || record.scope)}">${record.scope || record.scope}</span>
                    </td>
                    <td style="font-size: 12px;">${record.authorship}</td>
                    <td style="font-size: 12px;">${record.author_details ? (record.author_details.length > 50 ? record.author_details.substring(0, 50) + '...' : record.author_details) : '-'}</td>
                    <td style="font-size: 12px;">${record.month_of_publication} ${record.year_of_publication}</td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getStatusBadgeClass(record.submitted_to_university)}">${record.submitted_to_university}</span>
                    </td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getPublicationStatusBadgeClass(record.publication_status)}">${record.publication_status || '-'}</span>
                    </td>
                    <td style="font-size: 12px; display:none;">
                        <span class="badge bg-info text-white">${record.total_hours || '0'} hrs</span>
                    </td>
                    <td style="font-size: 12px;">
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-primary btn-sm" onclick="editPublicationRecord(${actualIndex})" title="Edit Record">
                                <i class="fas fa-edit me-1"></i>
                                Edit
                            </button>
                            <button type="button" class="btn btn-danger btn-sm" onclick="deletePublicationRecord(${actualIndex})" title="Delete Record">
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

        // Update pagination info and controls
        updatePaginationInfo(startIndex + 1, endIndex, totalRecords);
        renderPaginationControls(totalPages);
    }

    function updatePaginationInfo(from, to, total) {
        $('#showingFrom').text(from);
        $('#showingTo').text(to);
        $('#totalRecords').text(total);
        
        if (total > 0) {
            $('#paginationControls').show();
        } else {
            $('#paginationControls').hide();
        }
    }

    function renderPaginationControls(totalPages) {
        var paginationList = $('#paginationList');
        paginationList.empty();

        if (totalPages <= 1) {
            $('#paginationControls').hide();
            return;
        }

        // Previous button
        var prevDisabled = currentPage === 1 ? 'disabled' : '';
        paginationList.append(`
            <li class="page-item ${prevDisabled}">
                <a class="page-link" href="javascript:void(0)" onclick="changePage(${currentPage - 1})">
                    <i class="fas fa-chevron-left"></i> Previous
                </a>
            </li>
        `);

        // Page numbers logic
        var maxPagesToShow = 5;
        var startPage = Math.max(1, currentPage - Math.floor(maxPagesToShow / 2));
        var endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);

        // Adjust start if we're near the end
        if (endPage - startPage < maxPagesToShow - 1) {
            startPage = Math.max(1, endPage - maxPagesToShow + 1);
        }

        // First page if not visible
        if (startPage > 1) {
            paginationList.append(`
                <li class="page-item">
                    <a class="page-link" href="javascript:void(0)" onclick="changePage(1)">1</a>
                </li>
            `);
            if (startPage > 2) {
                paginationList.append(`<li class="page-item disabled"><span class="page-link">...</span></li>`);
            }
        }

        // Page numbers
        for (var i = startPage; i <= endPage; i++) {
            var activeClass = i === currentPage ? 'active' : '';
            paginationList.append(`
                <li class="page-item ${activeClass}">
                    <a class="page-link" href="javascript:void(0)" onclick="changePage(${i})">${i}</a>
                </li>
            `);
        }

        // Last page if not visible
        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                paginationList.append(`<li class="page-item disabled"><span class="page-link">...</span></li>`);
            }
            paginationList.append(`
                <li class="page-item">
                    <a class="page-link" href="javascript:void(0)" onclick="changePage(${totalPages})">${totalPages}</a>
                </li>
            `);
        }

        // Next button
        var nextDisabled = currentPage === totalPages ? 'disabled' : '';
        paginationList.append(`
            <li class="page-item ${nextDisabled}">
                <a class="page-link" href="javascript:void(0)" onclick="changePage(${currentPage + 1})">
                    Next <i class="fas fa-chevron-right"></i>
                </a>
            </li>
        `);
    }

    function changePage(page) {
        var totalPages = Math.ceil(publicationsRecords.length / recordsPerPage);
        
        if (page < 1 || page > totalPages) {
            return;
        }
        
        currentPage = page;
        displayPublicationsRecords();
        
        // Scroll to top of the table
        $('html, body').animate({
            scrollTop: $('#publicationsRecordsList').offset().top - 100
        }, 300);
    }

    function getPublicationTypeBadgeClass(publicationType) {
        switch (publicationType) {
            case 'Journal Article': return 'bg-primary';
            case 'Conference Paper': return 'bg-info';
            case 'Book Chapter': return 'bg-warning';
            case 'Book': return 'bg-success';
            case 'Patent': return 'bg-danger';
            case 'Technical Report': return 'bg-secondary';
            default: return 'bg-secondary';
        }
    }

    function getScopeBadgeClass(scope) {
        switch (scope) {
            case 'National': return 'bg-warning';
            case 'International': return 'bg-success';
            default: return 'bg-secondary';
        }
    }

    function getStatusBadgeClass(status) {
        switch (status) {
            case 'Yes': return 'bg-success';
            case 'No': return 'bg-secondary';
            case 'Under Review': return 'bg-warning';
            case 'Accepted': return 'bg-primary';
            case 'Rejected': return 'bg-danger';
            default: return 'bg-secondary';
        }
    }

    function getPublicationStatusBadgeClass(status) {
        switch (status) {
            case 'Published': return 'bg-success';
            case 'Accepted': return 'bg-primary';
            case 'Under Review': return 'bg-warning';
            case 'Submitted': return 'bg-info';
            case 'In Progress': return 'bg-secondary';
            case 'Rejected': return 'bg-danger';
            default: return 'bg-secondary';
        }
    }

    function saveAllPublicationsDetails() {
        if (publicationsRecords.length === 0) {
            showErrorMessage('No publication records to save');
            return;
        }

        $('#btnSaveAll').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

        $.ajax({
            url: '../../WebService.asmx/SavePublicationType',
            type: 'POST',
            contentType: 'application/json; charset=utf-8',

            data: JSON.stringify({ formDataJson: JSON.stringify(publicationsRecords), yearcode: $('#yearFilter').val() }),
            dataType: 'json',
            success: function (response) {
                if (response && response.d) {
                    var result = response.d;
                    result = JSON.parse(result);
                    if (result.success) {
                        showTopRightMessage(result.message || 'Publications details saved successfully!');
                        $('#btnNext').prop('disabled', false);
                    } else {
                        showErrorMessage(result.message || 'Failed to save publications details');
                        if (result.error) {
                            console.error('Error details:', result.error);
                        }
                    }
                } else {
                    showErrorMessage('Failed to save publications details');
                }
            },
            error: function (xhr, status, error) {
                showErrorMessage('Error saving publications details: ' + error);
                console.error('AJAX Error:', xhr.responseText);
            },
            complete: function () {
                $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
            }
        });
    }


    function loadPublicationsType() {
        $.ajax({
            url: '../../WebService.asmx/GetPublicationType',
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            data: "{publicationtype : 'Publication'}",
            dataType: 'json',
            success: function (response) {
                if (response && response.d) {
                    var result = response.d;
                    result = JSON.parse(result);
                    if (result.length > 0) {
                        // Clear existing options except the first one
                        $('#publication_type').find('option:not(:first)').remove();

                        // Add new options from the web service
                        $.each(result, function (index, item) {
                            var typeCode = item.TypeCode || item.TypeCode || item.TypeCode;
                            var typeName = item.TypeName || item.TypeName || item.TypeName;
                            
                            var option = $('<option></option>')
                                .attr('value', typeCode)
                                .text(typeName);
                            $('#publication_type').append(option);
                            
                            // Store mapping for Excel import: TypeName -> TypeCode
                            publicationTypesMapping[typeName] = typeCode;
                        });
                    }

                    // Load publications records after publication types are loaded
                    loadPublicationsRecords();
                }
            },
            error: function (xhr, status, error) {
                console.error('Error loading publication types:', error);
                // Keep default options if web service fails
                // Still load publications records even if types fail
                loadPublicationsRecords();
            }
        });
    }

    function loadPublicationsRecords(yearCode) {
        // If yearCode is not provided, use empty string to load all records
        var year = yearCode || '';

        $.ajax({
            url: '../../WebService.asmx/GetPublicationsDetails',
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({ yearcode: $('#yearFilter').val() }),
            dataType: 'json',
            success: function (response) {
                if (response && response.d) {
                    var result = response.d;
                    result = JSON.parse(result);
                    if (result.length > 0) {
                        // Process each record to add publication_type_name
                        result.forEach(function (record) {
                            // If publication_type_name is not provided, we'll need to get it from the dropdown options
                            if (!record.publication_type_name && record.publication_type) {
                                // Find the corresponding type name from the dropdown
                                $('#publication_type option').each(function () {
                                    if ($(this).val() === record.publication_type) {
                                        record.publication_type_name = $(this).text();
                                        return false; // Break the loop
                                    }
                                });
                            }
                        });

                        publicationsRecords = result;
                        currentPage = 1; // Reset to first page when loading records
                        displayPublicationsRecords();
                    }
                }
            },
            error: function (xhr, status, error) {
                console.error('Error loading publications records:', error);
            }
        });
    }

    function populateYearFilterDropdown() {
        // Generate academic years from current year back to 10 years
        var currentYear = new Date().getFullYear();
        var startYear = currentYear - 10;

        // Clear existing options except the first one
        $('#yearFilter').find('option:not(:first)').remove();

        // Add academic years in descending order (newest first)
        for (var year = currentYear; year >= startYear; year--) {
            var nextYear = year + 1;
            var academicYear = year + '-' + nextYear;
            var option = $('<option></option>')
                .attr('value', academicYear)
                .text(academicYear);
            $('#yearFilter').append(option);
        }

        // Set current academic year as default selected value
        var currentAcademicYear = currentYear + '-' + (currentYear + 1);
        $('#yearFilter').val(currentAcademicYear);
    }

    function loadPublicationsByYear() {
        var selectedYear = $('#yearFilter').val();

        if (!selectedYear) {
            showErrorMessage('Please select a year first');
            return;
        }

        // Show loading state
        $('#btnLoadData').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Loading...');

        // Load publications for selected year from database using yearcode parameter
        $.ajax({
            url: '../../WebService.asmx/GetPublicationsDetails',
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({ yearcode: selectedYear }),
            dataType: 'json',
            success: function (response) {
                if (response && response.d) {
                    var result = response.d;
                    result = JSON.parse(result);

                    if (result.length > 0) {
                        // Process each record to add publication_type_name
                        result.forEach(function (record) {
                            if (!record.publication_type_name && record.publication_type) {
                                $('#publication_type option').each(function () {
                                    if ($(this).val() === record.publication_type) {
                                        record.publication_type_name = $(this).text();
                                        return false;
                                    }
                                });
                            }
                        });

                        publicationsRecords = result;
                        displayFilteredPublicationsByYear(result, selectedYear);
                        showTopRightMessage('Loaded ' + result.length + ' publication(s) for year ' + selectedYear);
                    } else {
                        publicationsRecords = [];
                        displayFilteredPublicationsByYear([], selectedYear);
                    }
                } else {
                    showErrorMessage('Failed to load publications for selected year');
                }
            },
            error: function (xhr, status, error) {
                showErrorMessage('Error loading publications: ' + error);
                console.error('AJAX Error:', xhr.responseText);
            },
            complete: function () {
                $('#btnLoadData').prop('disabled', false).html('<i class="fas fa-search me-2"></i>Load Data');
            }
        });
    }

    function loadCurrentYearPublications() {
        var currentYear = new Date().getFullYear();
        var currentAcademicYear = currentYear + '-' + (currentYear + 1);
        // Set the year filter to current academic year
        $('#yearFilter').val(currentAcademicYear);
        // Filter publications by current academic year
        var filteredRecords = publicationsRecords.filter(function (record) {
            return record.year_of_publication &&
                record.year_of_publication.toString() === currentAcademicYear;
        });
        displayFilteredPublicationsByYear(filteredRecords, currentAcademicYear + ' (Current Year)');
    }

    function displayFilteredPublicationsByYear(filteredRecords, yearText) {
        var container = $('#publicationsRecordsList');

        if (filteredRecords.length === 0) {
            container.html(`
                <div class="text-center text-muted py-4">
                    <i class="fas fa-calendar-times fa-2x mb-3"></i>
                    <p>No publications found for year: <strong>${yearText}</strong></p>
                    <button type="button" class="btn btn-sm btn-secondary" onclick="displayPublicationsRecords()">
                        <i class="fas fa-list me-1"></i>Show All Publications
                    </button>
                </div>
            `);
            return;
        }

        var html = `
            <div class="alert alert-info alert-dismissible fade show mb-3" role="alert">
                <i class="fas fa-calendar-check me-2"></i>
                Showing <strong>${filteredRecords.length}</strong> publication(s) for year: <strong>${yearText}</strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-light">
                        <tr>
                            <th style="font-size: 12px; font-weight: 600;">S.No</th>
                            <th style="font-size: 12px; font-weight: 600;">Publication Type</th>
                            <th style="font-size: 12px; font-weight: 600;">Title of Research</th>
                            <th style="font-size: 12px; font-weight: 600;">Journal/Conference</th>
                            <th style="font-size: 12px; font-weight: 600;">Scope</th>
                            <th style="font-size: 12px; font-weight: 600;">Authorship</th>
                            <th style="font-size: 12px; font-weight: 600;">Author Details</th>
                            <th style="font-size: 12px; font-weight: 600;">Publication Date</th>
                            <th style="font-size: 12px; font-weight: 600;">Submitted Status</th>
                            <th style="font-size: 12px; font-weight: 600;">Publication Status</th>
                            <th style="font-size: 12px; font-weight: 600; display:none;">Total Hours</th>
                            <th style="font-size: 12px; font-weight: 600;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        filteredRecords.forEach(function (record, index) {
            var originalIndex = publicationsRecords.indexOf(record);

            html += `
                <tr>
                    <td style="font-size: 12px;">${index + 1}</td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getPublicationTypeBadgeClass(record.publication_type)}">${record.publication_type_name || record.publication_type}</span>
                    </td>
                    <td style="font-size: 12px;">${record.title_of_research ? (record.title_of_research.length > 30 ? record.title_of_research.substring(0, 30) + '...' : record.title_of_research) : '-'}</td>
                    <td style="font-size: 12px;">${record.journal_conference_name}</td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getScopeBadgeClass(record.scope || record.scope)}">${record.scope || record.scope}</span>
                    </td>
                    <td style="font-size: 12px;">${record.authorship}</td>
                    <td style="font-size: 12px;">${record.author_details ? (record.author_details.length > 50 ? record.author_details.substring(0, 50) + '...' : record.author_details) : '-'}</td>
                    <td style="font-size: 12px;">${record.month_of_publication} ${record.year_of_publication}</td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getStatusBadgeClass(record.submitted_to_university)}">${record.submitted_to_university}</span>
                    </td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getPublicationStatusBadgeClass(record.publication_status)}">${record.publication_status || '-'}</span>
                    </td>
                    <td style="font-size: 12px; display:none;">
                        <span class="badge bg-info text-white">${record.total_hours || '0'} hrs</span>
                    </td>
                    <td style="font-size: 12px;">
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-primary btn-sm" onclick="editPublicationRecord(${originalIndex})" title="Edit Record">
                                <i class="fas fa-edit me-1"></i>
                                Edit
                            </button>
                            <button type="button" class="btn btn-danger btn-sm" onclick="deletePublicationRecord(${originalIndex})" title="Delete Record">
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

    // All Years Publications Functions
    function loadAllYearsPublications() {
        // Show loading state
        $('#btnLoadAllYears').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Loading...');

        // Load all publications from database (pass empty string for yearcode to get all years)
        $.ajax({
            url: '../../WebService.asmx/GetPublicationsDetails',
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({ yearcode: '' }), // Empty string to get ALL years
            dataType: 'json',
            success: function (response) {
                if (response && response.d) {
                    var result = response.d;
                    result = JSON.parse(result);

                    if (result.length > 0) {
                        // Process each record to add publication_type_name
                        result.forEach(function (record) {
                            if (!record.publication_type_name && record.publication_type) {
                                $('#publication_type option').each(function () {
                                    if ($(this).val() === record.publication_type) {
                                        record.publication_type_name = $(this).text();
                                        return false;
                                    }
                                });
                            }
                        });

                        allYearsRecords = result;
                        allYearsCurrentPage = 1; // Reset to first page
                        displayAllYearsPublications();
                        showTopRightMessage('Loaded ' + result.length + ' publication(s) from all academic years');
                    } else {
                        allYearsRecords = [];
                        displayAllYearsPublications();
                        showTopRightMessage('No publications found in database');
                    }
                } else {
                    showErrorMessage('Failed to load all years publications');
                }
            },
            error: function (xhr, status, error) {
                showErrorMessage('Error loading publications: ' + error);
                console.error('AJAX Error:', xhr.responseText);
            },
            complete: function () {
                $('#btnLoadAllYears').prop('disabled', false).html('<i class="fas fa-sync me-2"></i>Load All Years Data');
            }
        });
    }

    function displayAllYearsPublications() {
        var container = $('#allYearsPublicationsList');
        var totalRecords = allYearsRecords.length;

        // Update records count badge
        $('#allYearsRecordsCount').text(totalRecords);

        if (totalRecords === 0) {
            container.html(`
                <div class="text-center text-muted py-4">
                    <i class="fas fa-database fa-2x mb-3"></i>
                    <p>No publications found in database from any year.</p>
                </div>
            `);
            $('#allYearsPaginationControls').hide();
            return;
        }

        // Calculate pagination
        var totalPages = Math.ceil(totalRecords / allYearsRecordsPerPage);
        var startIndex = (allYearsCurrentPage - 1) * allYearsRecordsPerPage;
        var endIndex = Math.min(startIndex + allYearsRecordsPerPage, totalRecords);

        // Get records for current page
        var pageRecords = allYearsRecords.slice(startIndex, endIndex);

        // Group records by year for summary
        var yearGroups = {};
        allYearsRecords.forEach(function(record) {
            var year = record.year_of_publication || 'Unknown';
            yearGroups[year] = (yearGroups[year] || 0) + 1;
        });

        // Create year summary text
        var yearSummary = Object.keys(yearGroups).sort().reverse().map(function(year) {
            return year + ' (' + yearGroups[year] + ')';
        }).join(', ');

        var html = `
            <div class="alert alert-success alert-dismissible fade show mb-3" role="alert" style="display: none !important;">
                <i class="fas fa-database me-2"></i>
                <strong>All Years Historical Data:</strong> Showing ${totalRecords} publication(s) from all academic years
                <br><small class="mt-1 d-block"><strong>Year Distribution:</strong> ${yearSummary}</small>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead class="table-success">
                        <tr>
                            <th style="font-size: 12px; font-weight: 600;">S.No</th>
                            <th style="font-size: 12px; font-weight: 600;">Year</th>
                            <th style="font-size: 12px; font-weight: 600;">Publication Type</th>
                            <th style="font-size: 12px; font-weight: 600;">Title of Research</th>
                            <th style="font-size: 12px; font-weight: 600;">Journal/Conference</th>
                            <th style="font-size: 12px; font-weight: 600;">Scope</th>
                            <th style="font-size: 12px; font-weight: 600;">Authorship</th>
                            <th style="font-size: 12px; font-weight: 600;">Publication Date</th>
                            <th style="font-size: 12px; font-weight: 600;">Status</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        pageRecords.forEach(function (record, pageIndex) {
            var actualIndex = startIndex + pageIndex;
            html += `
                <tr>
                    <td style="font-size: 12px;">${actualIndex + 1}</td>
                    <td style="font-size: 12px;">
                        <span class="badge bg-info">${record.year_of_publication || 'N/A'}</span>
                    </td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getPublicationTypeBadgeClass(record.publication_type)}">${record.publication_type_name || record.publication_type}</span>
                    </td>
                    <td style="font-size: 12px;" title="${record.title_of_research || '-'}">
                        ${record.title_of_research ? (record.title_of_research.length > 40 ? record.title_of_research.substring(0, 40) + '...' : record.title_of_research) : '-'}
                    </td>
                    <td style="font-size: 12px;">${record.journal_conference_name || '-'}</td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getScopeBadgeClass(record.scope)}">${record.scope || '-'}</span>
                    </td>
                    <td style="font-size: 12px;">${record.authorship || '-'}</td>
                    <td style="font-size: 12px;">${record.month_of_publication || ''} ${record.year_of_publication || ''}</td>
                    <td style="font-size: 12px;">
                        <span class="badge ${getPublicationStatusBadgeClass(record.publication_status)}">${record.publication_status || '-'}</span>
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

        // Update pagination info and controls
        updateAllYearsPaginationInfo(startIndex + 1, endIndex, totalRecords);
        renderAllYearsPaginationControls(totalPages);
    }

    function updateAllYearsPaginationInfo(from, to, total) {
        $('#allYearsShowingFrom').text(from);
        $('#allYearsShowingTo').text(to);
        $('#allYearsTotalRecords').text(total);
        
        if (total > 0) {
            $('#allYearsPaginationControls').show();
        } else {
            $('#allYearsPaginationControls').hide();
        }
    }

    function renderAllYearsPaginationControls(totalPages) {
        var paginationList = $('#allYearsPaginationList');
        paginationList.empty();

        if (totalPages <= 1) {
            $('#allYearsPaginationControls').hide();
            return;
        }

        // Previous button
        var prevDisabled = allYearsCurrentPage === 1 ? 'disabled' : '';
        paginationList.append(`
            <li class="page-item ${prevDisabled}">
                <a class="page-link" href="javascript:void(0)" onclick="changeAllYearsPage(${allYearsCurrentPage - 1})">
                    <i class="fas fa-chevron-left"></i> Previous
                </a>
            </li>
        `);

        // Page numbers logic
        var maxPagesToShow = 5;
        var startPage = Math.max(1, allYearsCurrentPage - Math.floor(maxPagesToShow / 2));
        var endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);

        // Adjust start if we're near the end
        if (endPage - startPage < maxPagesToShow - 1) {
            startPage = Math.max(1, endPage - maxPagesToShow + 1);
        }

        // First page if not visible
        if (startPage > 1) {
            paginationList.append(`
                <li class="page-item">
                    <a class="page-link" href="javascript:void(0)" onclick="changeAllYearsPage(1)">1</a>
                </li>
            `);
            if (startPage > 2) {
                paginationList.append(`<li class="page-item disabled"><span class="page-link">...</span></li>`);
            }
        }

        // Page numbers
        for (var i = startPage; i <= endPage; i++) {
            var activeClass = i === allYearsCurrentPage ? 'active' : '';
            paginationList.append(`
                <li class="page-item ${activeClass}">
                    <a class="page-link" href="javascript:void(0)" onclick="changeAllYearsPage(${i})">${i}</a>
                </li>
            `);
        }

        // Last page if not visible
        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                paginationList.append(`<li class="page-item disabled"><span class="page-link">...</span></li>`);
            }
            paginationList.append(`
                <li class="page-item">
                    <a class="page-link" href="javascript:void(0)" onclick="changeAllYearsPage(${totalPages})">${totalPages}</a>
                </li>
            `);
        }

        // Next button
        var nextDisabled = allYearsCurrentPage === totalPages ? 'disabled' : '';
        paginationList.append(`
            <li class="page-item ${nextDisabled}">
                <a class="page-link" href="javascript:void(0)" onclick="changeAllYearsPage(${allYearsCurrentPage + 1})">
                    Next <i class="fas fa-chevron-right"></i>
                </a>
            </li>
        `);
    }

    function changeAllYearsPage(page) {
        var totalPages = Math.ceil(allYearsRecords.length / allYearsRecordsPerPage);
        
        if (page < 1 || page > totalPages) {
            return;
        }
        
        allYearsCurrentPage = page;
        displayAllYearsPublications();
        
        // Scroll to top of the all years section
        $('html, body').animate({
            scrollTop: $('#allYearsSection').offset().top - 100
        }, 300);
    }

    function navigateToPreviousMenu() {
        window.location.href = 'CoursesTaught.aspx';
    }
    function navigateToNextMenu() {
        showTopRightMessage('Publications details completed!');
    }
    function showTopRightMessage(message) {
        $('.top-right-message').remove();
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
    function downloadExcelTemplate() {
        try {
            // Create workbook
            var wb = XLSX.utils.book_new();

            // Define headers
            var headers = [
                'Publication Type',
                'Journal/Conference Name',
                'Title of Research',
                'Scope',
                'Impact Factor',
                'Authorship',
                'Author Details',
                'Month of Publication',
                'Year of Publication',
                'Submitted to University',
                'Publication Status',
                'Total Hours'
            ];

            // Get available publication types from dropdown
            var availableTypes = [];
            $('#publication_type option').each(function() {
                var value = $(this).val();
                if (value) { // Skip empty option
                    availableTypes.push($(this).text());
                }
            });
            
            // Use first available type or default
            var firstType = availableTypes.length > 0 ? availableTypes[0] : 'Journal Article';
            var secondType = availableTypes.length > 1 ? availableTypes[1] : 'Conference Paper';
            
            var sampleData1 = [
                firstType,
                'IEEE Transactions on Software Engineering',
                'Machine Learning in Software Testing: A Comprehensive Study',
                'International',
                '4.5',
                'First Author',
                'John Doe, Jane Smith, Robert Brown',
                'January',
                '2024',
                'Yes',
                'Accepted',
                '100'
            ];

            var sampleData2 = [
                secondType,
                'ACM SIGSOFT International Symposium',
                'Automated Bug Detection using Deep Learning',
                'International',
                '2.3',
                'Co-Author',
                'Alice Johnson, Bob Wilson',
                'March',
                '2024',
                'No',
                'Accepted',
                '80'
            ];
            
            // Build available types string for instructions
            var typesString = availableTypes.length > 0 ? availableTypes.join(', ') : 'Journal Article, Conference Paper, Book Chapter, Book, Patent, Technical Report';
            
            var instructions = [
                'INSTRUCTIONS:',
                '1. Fill your publication data starting from Row 4',
                '2. Delete these sample rows before uploading',
                '3. Required fields: Publication Type, Journal/Conference Name, Title of Research',
                '4. Use exact values for dropdown fields (Publication Type, Scope, Authorship, etc.)',
                '5. Available Publication Types: ' + typesString,
                '6. Month: January-December | Year: 2020-2025',
                '7. Scope: National or International',
                '8. Authorship: First Author, Second Author, Third Author, Corresponding Author, Co-Author',
                '9. Submitted to University: Yes or No',
                '10. Publication Status: Published, Accepted, Under Review, Submitted, In Progress, Rejected',
                '11. Save file and upload using "Upload & Import" button',
                ''
            ];

            // Create data array
            var wsData = [
                headers,
                sampleData1,
                sampleData2,
                [''],
                instructions
            ];
            var ws = XLSX.utils.aoa_to_sheet(wsData);
            ws['!cols'] = [
                { wch: 18 }, // Publication Type
                { wch: 30 }, // Journal/Conference Name
                { wch: 40 }, // Title of Research
                { wch: 15 }, // Scope
                { wch: 15 }, // Impact Factor
                { wch: 20 }, // Authorship
                { wch: 35 }, // Author Details
                { wch: 15 }, // Month
                { wch: 12 }, // Year
                { wch: 20 }, // Submitted to University
                { wch: 18 }, // Publication Status
                { wch: 12 }  // Total Hours
            ];

            
            XLSX.utils.book_append_sheet(wb, ws, 'Publications');
            var today = new Date();
            var dateStr = today.getFullYear() + 
                         String(today.getMonth() + 1).padStart(2, '0') + 
                         String(today.getDate()).padStart(2, '0');
            var fileName = 'Publications_Template_' + dateStr + '.xlsx';
            XLSX.writeFile(wb, fileName);
            showTopRightMessage('Excel template downloaded successfully!');
        } catch (error) {
            console.error('Error downloading Excel template:', error);
            showErrorMessage('Error generating Excel template: ' + error.message);
        }
    }
    function uploadAndParseExcel(file) {
        try {
            var reader = new FileReader();

            reader.onload = function (e) {
                try {
                    var data = new Uint8Array(e.target.result);
                    var workbook = XLSX.read(data, { type: 'array' });
                    var firstSheetName = workbook.SheetNames[0];
                    var worksheet = workbook.Sheets[firstSheetName];
                    var jsonData = XLSX.utils.sheet_to_json(worksheet, { 
                        header: 1,
                        defval: '',
                        blankrows: false
                    });

                    if (jsonData.length === 0) {
                        showErrorMessage('Excel file is empty or has no data rows!');
                        return;
                    }
                    parseExcelData(jsonData);

                } catch (parseError) {
                    console.error('Error parsing Excel file:', parseError);
                    showErrorMessage('Error parsing Excel file: ' + parseError.message);
                }
            };

            reader.onerror = function (error) {
                console.error('Error reading file:', error);
                showErrorMessage('Error reading Excel file!');
            };

            reader.readAsArrayBuffer(file);

        } catch (error) {
            console.error('Error uploading Excel:', error);
            showErrorMessage('Error uploading Excel file: ' + error.message);
        }
    }
    function parseExcelData(jsonData) {
        excelDataPreview = [];
        var headers = jsonData[0];
        
        // Log available publication types mapping for debugging
        console.log('Available Publication Types Mapping:', publicationTypesMapping);
        
        for (var i = 1; i < jsonData.length; i++) {
            var row = jsonData[i];
            // Skip empty rows and instruction rows
            if (!row || row.length === 0) continue;
            if (row[0] && (row[0].toString().includes('INSTRUCTIONS') || 
                          row[0].toString().includes('Fill your publication'))) {
                continue;
            }

            // Extract data from columns
            var publicationType = row[0] ? row[0].toString().trim() : '';
            var journalName = row[1] ? row[1].toString().trim() : '';
            var titleResearch = row[2] ? row[2].toString().trim() : '';
            var scope = row[3] ? row[3].toString().trim() : '';
            var impactFactor = row[4] ? row[4].toString().trim() : '';
            var authorship = row[5] ? row[5].toString().trim() : '';
            var authorDetails = row[6] ? row[6].toString().trim() : '';
            var monthPub = row[7] ? row[7].toString().trim() : '';
            var yearPub = row[8] ? row[8].toString().trim() : '';
            var submittedUni = row[9] ? row[9].toString().trim() : '';
            var pubStatus = row[10] ? row[10].toString().trim() : '';
            var totalHours = row[11] ? row[11].toString().trim() : '0';

            // Skip if all required fields are empty
            if (!publicationType && !journalName && !titleResearch) {
                continue;
            }

            // Validate required fields
            if (!publicationType || !journalName || !titleResearch) {
                console.warn('Skipping row ' + (i + 1) + ': Missing required fields');
                continue;
            }

            // Map publication type name to database TypeCode
            var publicationTypeCode = publicationTypesMapping[publicationType];
            
            // If mapping not found, try to find by partial match (case-insensitive)
            if (!publicationTypeCode) {
                for (var typeName in publicationTypesMapping) {
                    if (typeName.toLowerCase() === publicationType.toLowerCase()) {
                        publicationTypeCode = publicationTypesMapping[typeName];
                        publicationType = typeName; // Use the exact name from database
                        break;
                    }
                }
            }
            
            // If still not found, skip this row
            if (!publicationTypeCode) {
                console.warn('Skipping row ' + (i + 1) + ': Invalid Publication Type "' + publicationType + '"');
                continue;
            }

            // Create publication object
            var publicationData = {
                publication_type: publicationTypeCode, // Database TypeCode
                publication_type_name: publicationType, // Display name
                journal_conference_name: journalName,
                title_of_research: titleResearch,
                scope: scope || 'National',
                impact_factor: impactFactor,
                authorship: authorship || 'Co-Author',
                author_details: authorDetails,
                month_of_publication: monthPub || 'January',
                year_of_publication: yearPub || new Date().getFullYear().toString(),
                submitted_to_university: submittedUni || 'No',
                publication_status: pubStatus || 'In Progress',
                total_hours: totalHours || '0',
                id: Date.now() + i
            };

            excelDataPreview.push(publicationData);
        }

        if (excelDataPreview.length === 0) {
            showErrorMessage('No valid data found in Excel file! Please check required fields.');
            return;
        }

        // Display preview
        displayExcelPreview();
        showTopRightMessage('Found ' + excelDataPreview.length + ' publication(s) in Excel file!');
    }
    function displayExcelPreview() {
        var tbody = $('#excelPreviewBody');
        tbody.empty();

        excelDataPreview.forEach(function (record, index) {
            var row = `
                <tr>
                    <td>${index + 1}</td>
                    <td>${record.publication_type_name || record.publication_type}</td>
                    <td>${record.journal_conference_name}</td>
                    <td title="${record.title_of_research}">${record.title_of_research.length > 40 ? record.title_of_research.substring(0, 40) + '...' : record.title_of_research}</td>
                    <td>${record.scope}</td>
                    <td>${record.impact_factor || '-'}</td>
                    <td>${record.authorship}</td>
                    <td title="${record.author_details}">${record.author_details ? (record.author_details.length > 30 ? record.author_details.substring(0, 30) + '...' : record.author_details) : '-'}</td>
                    <td>${record.month_of_publication}</td>
                    <td>${record.year_of_publication}</td>
                    <td>${record.submitted_to_university}</td>
                    <td>${record.publication_status}</td>
                </tr>
            `;
            tbody.append(row);
        });

        // Update record count
        $('#excelRecordCount').text(excelDataPreview.length);

        // Show preview section with smooth scroll
        $('#excelPreviewSection').slideDown();
        
        // Scroll to preview
        setTimeout(function () {
            $('html, body').animate({
                scrollTop: $('#excelPreviewSection').offset().top - 20
            }, 500);
        }, 300);
    }
    function confirmExcelImport() {
        if (excelDataPreview.length === 0) {
            showErrorMessage('No data to import!');
            return;
        }
        excelDataPreview.forEach(function (record) {
            publicationsRecords.push(record);
        });

        // Display updated records
        currentPage = 1; // Reset to first page when importing records
        displayPublicationsRecords();

        // Auto-save to database
        showTopRightMessage('Importing ' + excelDataPreview.length + ' publication(s)...');
        
        setTimeout(function () {
            saveAllPublicationsDetails();
        }, 500);

        // Clear preview
        cancelExcelImport();

        showTopRightMessage('Successfully imported ' + excelDataPreview.length + ' publication(s)!');
    }
    function cancelExcelImport() {
        excelDataPreview = [];
        $('#excelPreviewBody').empty();
        $('#excelPreviewSection').slideUp();
        $('#excelFileUpload').val('');
    }
</script>

</asp:Content>

