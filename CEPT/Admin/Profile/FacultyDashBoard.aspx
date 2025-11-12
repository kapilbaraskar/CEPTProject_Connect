<%@ Page Title="Faculty DashBoard" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="FacultyDashBoard.aspx.cs" Inherits="Admin_Profile_FacultyDashBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="dashboard-container">
        <!-- Modern Header -->
        <div class="modern-header">
            <div class="container-fluid">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="header-content">
                            <div class="welcome-section">
                                <h1 class="main-title">Welcome back, Dr. Smith</h1>
                                <p class="subtitle">Here's your profile overview and latest updates</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="header-actions">
                            <div class="action-buttons">
                                <button type="button" class="btn btn-primary btn-modern">
                                    <i class="fas fa-plus"></i>
                                    Add New
                                </button>
                                <button type="button" id="btnRefreshDashboard" class="btn btn-outline-primary btn-modern">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                            <div class="profile-section">
                                <div class="profile-info">
                                    <div class="profile-details">
                                        <h6 class="profile-name">Dr. John Smith</h6>
                                        <span class="profile-role">Senior Professor</span>
                                    </div>
                                    <div class="profile-avatar">
                                        <img src="https://via.placeholder.com/40x40/007bff/ffffff?text=JS" alt="Profile" class="avatar-img">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Summary Cards -->
        <div class="row mb-4">
            <!-- Personal Details Card -->
            <div class="col-md-3 mb-3">
                <div class="card summary-card" id="personalDetailsCard">
                    <div class="card-body text-center">
                        <div class="summary-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <h5 class="card-title">Personal Details</h5>
                        <div class="summary-stats">
                            <span class="stat-value" id="personalDetailsStatus">Loading...</span>
                            <span class="stat-label">Completion</span>
                        </div>
                        <div class="progress mb-2" style="height: 6px;">
                            <div class="progress-bar bg-primary" id="personalDetailsProgress" style="width: 0%"></div>
                        </div>
                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="navigateToPage('PersonalDetails.aspx')">
                            <i class="fas fa-edit me-1"></i>
                            Manage
                        </button>
                    </div>
                </div>
            </div>

            <!-- Experience Details Card -->
            <div class="col-md-3 mb-3">
                <div class="card summary-card" id="experienceDetailsCard">
                    <div class="card-body text-center">
                        <div class="summary-icon">
                            <i class="fas fa-briefcase"></i>
                        </div>
                        <h5 class="card-title">Experience</h5>
                        <div class="summary-stats">
                            <span class="stat-value" id="experienceDetailsStatus">Loading...</span>
                            <span class="stat-label">Records</span>
                        </div>
                        <div class="progress mb-2" style="height: 6px;">
                            <div class="progress-bar bg-success" id="experienceDetailsProgress" style="width: 0%"></div>
                        </div>
                        <button type="button" class="btn btn-outline-success btn-sm" onclick="navigateToPage('ExperienceDetails.aspx')">
                            <i class="fas fa-edit me-1"></i>
                            Manage
                        </button>
                    </div>
                </div>
            </div>

            <!-- Publications Card -->
            <div class="col-md-3 mb-3">
                <div class="card summary-card" id="publicationsCard">
                    <div class="card-body text-center">
                        <div class="summary-icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <h5 class="card-title">Publications</h5>
                        <div class="summary-stats">
                            <span class="stat-value" id="publicationsStatus">Loading...</span>
                            <span class="stat-label">Records</span>
                        </div>
                        <div class="progress mb-2" style="height: 6px;">
                            <div class="progress-bar bg-info" id="publicationsProgress" style="width: 0%"></div>
                        </div>
                        <button type="button" class="btn btn-outline-info btn-sm" onclick="navigateToPage('Publication.aspx')">
                            <i class="fas fa-edit me-1"></i>
                            Manage
                        </button>
                    </div>
                </div>
            </div>

            <!-- Area of Expertise Card -->
            <div class="col-md-3 mb-3">
                <div class="card summary-card" id="expertiseCard">
                    <div class="card-body text-center">
                        <div class="summary-icon">
                            <i class="fas fa-lightbulb"></i>
                        </div>
                        <h5 class="card-title">Expertise</h5>
                        <div class="summary-stats">
                            <span class="stat-value" id="expertiseStatus">Loading...</span>
                            <span class="stat-label">Areas</span>
                        </div>
                        <div class="progress mb-2" style="height: 6px;">
                            <div class="progress-bar bg-warning" id="expertiseProgress" style="width: 0%"></div>
                        </div>
                        <button type="button" class="btn btn-outline-warning btn-sm" onclick="navigateToPage('AreaofExpertise.aspx')">
                            <i class="fas fa-edit me-1"></i>
                            Manage
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Additional Profile Sections -->
        <div class="row mb-4">
            <!-- Documents Card -->
            <div class="col-md-4 mb-3">
                <div class="card summary-card" id="documentsCard">
                    <div class="card-body text-center">
                        <div class="summary-icon">
                            <i class="fas fa-file-alt"></i>
                        </div>
                        <h5 class="card-title">Documents</h5>
                        <div class="summary-stats">
                            <span class="stat-value" id="documentsStatus">Loading...</span>
                            <span class="stat-label">Uploaded</span>
                        </div>
                        <div class="progress mb-2" style="height: 6px;">
                            <div class="progress-bar bg-secondary" id="documentsProgress" style="width: 0%"></div>
                        </div>
                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="navigateToPage('UploadDocument.aspx')">
                            <i class="fas fa-edit me-1"></i>
                            Manage
                        </button>
                    </div>
                </div>
            </div>

            <!-- Training Programs Card -->
            <div class="col-md-4 mb-3">
                <div class="card summary-card" id="trainingCard">
                    <div class="card-body text-center">
                        <div class="summary-icon">
                            <i class="fas fa-graduation-cap"></i>
                        </div>
                        <h5 class="card-title">Training</h5>
                        <div class="summary-stats">
                            <span class="stat-value" id="trainingStatus">Loading...</span>
                            <span class="stat-label">Programs</span>
                        </div>
                        <div class="progress mb-2" style="height: 6px;">
                            <div class="progress-bar bg-dark" id="trainingProgress" style="width: 0%"></div>
                        </div>
                        <button type="button" class="btn btn-outline-dark btn-sm" onclick="navigateToPage('TrainingProgram.aspx')">
                            <i class="fas fa-edit me-1"></i>
                            Manage
                        </button>
                    </div>
                </div>
            </div>

            <!-- Courses Taught Card -->
            <div class="col-md-4 mb-3">
                <div class="card summary-card" id="coursesCard">
                    <div class="card-body text-center">
                        <div class="summary-icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <h5 class="card-title">Courses</h5>
                        <div class="summary-stats">
                            <span class="stat-value" id="coursesStatus">Loading...</span>
                            <span class="stat-label">Taught</span>
                        </div>
                        <div class="progress mb-2" style="height: 6px;">
                            <div class="progress-bar bg-danger" id="coursesProgress" style="width: 0%"></div>
                        </div>
                        <button type="button" class="btn btn-outline-danger btn-sm" onclick="navigateToPage('CoursesTaught.aspx')">
                            <i class="fas fa-edit me-1"></i>
                            Manage
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts and Analytics Section -->
        <div class="row mb-4">
            <!-- Profile Completion Chart -->
            <div class="col-md-6 mb-4">
                <div class="chart-card">
                    <div class="chart-header">
                        <h5 class="chart-title">
                            <i class="fas fa-chart-pie me-2"></i>
                            Profile Completion
                        </h5>
                        <div class="chart-actions">
                            <button class="btn-chart-action active" data-chart="pie">
                                <i class="fas fa-chart-pie"></i>
                            </button>
                            <button class="btn-chart-action" data-chart="bar">
                                <i class="fas fa-chart-bar"></i>
                            </button>
                        </div>
                    </div>
                    <div class="chart-body">
                        <div class="chart-container">
                            <canvas id="profileCompletionChart" width="400" height="300"></canvas>
                        </div>
                        <div class="chart-legend">
                            <div class="legend-item">
                                <span class="legend-color" style="background: #007bff;"></span>
                                <span class="legend-label">Personal Details</span>
                                <span class="legend-value" id="piePersonal">85%</span>
                            </div>
                            <div class="legend-item">
                                <span class="legend-color" style="background: #28a745;"></span>
                                <span class="legend-label">Experience</span>
                                <span class="legend-value" id="pieExperience">70%</span>
                            </div>
                            <div class="legend-item">
                                <span class="legend-color" style="background: #17a2b8;"></span>
                                <span class="legend-label">Publications</span>
                                <span class="legend-value" id="piePublications">60%</span>
                            </div>
                            <div class="legend-item">
                                <span class="legend-color" style="background: #ffc107;"></span>
                                <span class="legend-label">Expertise</span>
                                <span class="legend-value" id="pieExpertise">50%</span>
                            </div>
                            <div class="legend-item">
                                <span class="legend-color" style="background: #6c757d;"></span>
                                <span class="legend-label">Documents</span>
                                <span class="legend-value" id="pieDocuments">100%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Activity Timeline Chart -->
            <div class="col-md-6 mb-4">
                <div class="chart-card">
                    <div class="chart-header">
                        <h5 class="chart-title">
                            <i class="fas fa-chart-line me-2"></i>
                            Activity Timeline
                        </h5>
                        <div class="chart-filters">
                            <select class="form-select form-select-sm" id="timelineFilter">
                                <option value="7">Last 7 days</option>
                                <option value="30" selected>Last 30 days</option>
                                <option value="90">Last 90 days</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-body">
                        <div class="chart-container">
                            <canvas id="activityTimelineChart" width="400" height="300"></canvas>
                        </div>
                        <div class="timeline-stats">
                            <div class="timeline-stat">
                                <span class="stat-number" id="totalActivities">47</span>
                                <span class="stat-label">Total Activities</span>
                            </div>
                            <div class="timeline-stat">
                                <span class="stat-number" id="avgDaily">2.3</span>
                                <span class="stat-label">Daily Average</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Data Distribution Charts -->
        <div class="row mb-4">
            <!-- Publications Distribution -->
            <div class="col-md-4 mb-3">
                <div class="mini-chart-card">
                    <div class="mini-chart-header">
                        <h6 class="mini-chart-title">
                            <i class="fas fa-book me-2"></i>
                            Publications by Type
                        </h6>
                    </div>
                    <div class="mini-chart-body">
                        <div class="mini-chart-container">
                            <canvas id="publicationsChart" width="200" height="200"></canvas>
                        </div>
                        <div class="mini-chart-data">
                            <div class="data-item">
                                <span class="data-label">Journal Articles</span>
                                <span class="data-value">8</span>
                            </div>
                            <div class="data-item">
                                <span class="data-label">Conference Papers</span>
                                <span class="data-value">3</span>
                            </div>
                            <div class="data-item">
                                <span class="data-label">Book Chapters</span>
                                <span class="data-value">1</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Experience Distribution -->
            <div class="col-md-4 mb-3">
                <div class="mini-chart-card">
                    <div class="mini-chart-header">
                        <h6 class="mini-chart-title">
                            <i class="fas fa-briefcase me-2"></i>
                            Experience by Type
                        </h6>
                    </div>
                    <div class="mini-chart-body">
                        <div class="mini-chart-container">
                            <canvas id="experienceChart" width="200" height="200"></canvas>
                        </div>
                        <div class="mini-chart-data">
                            <div class="data-item">
                                <span class="data-label">Teaching</span>
                                <span class="data-value">4</span>
                            </div>
                            <div class="data-item">
                                <span class="data-label">Industry</span>
                                <span class="data-value">2</span>
                            </div>
                            <div class="data-item">
                                <span class="data-label">Research</span>
                                <span class="data-value">1</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Expertise Level Distribution -->
            <div class="col-md-4 mb-3">
                <div class="mini-chart-card">
                    <div class="mini-chart-header">
                        <h6 class="mini-chart-title">
                            <i class="fas fa-lightbulb me-2"></i>
                            Expertise Levels
                        </h6>
                    </div>
                    <div class="mini-chart-body">
                        <div class="mini-chart-container">
                            <canvas id="expertiseChart" width="200" height="200"></canvas>
                        </div>
                        <div class="mini-chart-data">
                            <div class="data-item">
                                <span class="data-label">Expert</span>
                                <span class="data-value">2</span>
                            </div>
                            <div class="data-item">
                                <span class="data-label">Advanced</span>
                                <span class="data-value">2</span>
                            </div>
                            <div class="data-item">
                                <span class="data-label">Intermediate</span>
                                <span class="data-value">1</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Detailed Statistics Section -->
        <div class="row">
            <!-- Recent Activity -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-clock me-2"></i>
                            Recent Activity
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="recentActivityList">
                            <div class="text-center text-muted py-3">
                                <i class="fas fa-spinner fa-spin me-2"></i>
                                Loading recent activity...
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Profile Completion -->
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-chart-pie me-2"></i>
                            Profile Completion
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="completion-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span>Personal Details</span>
                                <span class="badge bg-primary" id="personalCompletionBadge">0%</span>
                            </div>
                            <div class="progress mb-3" style="height: 8px;">
                                <div class="progress-bar bg-primary" id="personalCompletionBar" style="width: 0%"></div>
                            </div>
                        </div>

                        <div class="completion-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span>Experience Records</span>
                                <span class="badge bg-success" id="experienceCompletionBadge">0</span>
                            </div>
                            <div class="progress mb-3" style="height: 8px;">
                                <div class="progress-bar bg-success" id="experienceCompletionBar" style="width: 0%"></div>
                            </div>
                        </div>

                        <div class="completion-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span>Publications</span>
                                <span class="badge bg-info" id="publicationsCompletionBadge">0</span>
                            </div>
                            <div class="progress mb-3" style="height: 8px;">
                                <div class="progress-bar bg-info" id="publicationsCompletionBar" style="width: 0%"></div>
                            </div>
                        </div>

                        <div class="completion-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span>Expertise Areas</span>
                                <span class="badge bg-warning" id="expertiseCompletionBadge">0</span>
                            </div>
                            <div class="progress mb-3" style="height: 8px;">
                                <div class="progress-bar bg-warning" id="expertiseCompletionBar" style="width: 0%"></div>
                            </div>
                        </div>

                        <div class="completion-item">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span>Documents</span>
                                <span class="badge bg-secondary" id="documentsCompletionBadge">0</span>
                            </div>
                            <div class="progress mb-3" style="height: 8px;">
                                <div class="progress-bar bg-secondary" id="documentsCompletionBar" style="width: 0%"></div>
                            </div>
                        </div>

                        <hr>
                        <div class="text-center">
                            <h6 class="text-muted">Overall Profile Completion</h6>
                            <div class="overall-progress">
                                <span class="display-6 fw-bold text-primary" id="overallCompletion">0%</span>
                            </div>
                            <div class="progress mt-2" style="height: 12px;">
                                <div class="progress-bar bg-gradient" id="overallCompletionBar" style="width: 0%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-bolt me-2"></i>
                    Quick Actions
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-2 mb-2">
                        <button type="button" class="btn btn-primary w-100" onclick="navigateToPage('PersonalDetails.aspx')">
                            <i class="fas fa-user me-2"></i>
                            Personal Details
                        </button>
                    </div>
                    <div class="col-md-2 mb-2">
                        <button type="button" class="btn btn-success w-100" onclick="navigateToPage('ExperienceDetails.aspx')">
                            <i class="fas fa-briefcase me-2"></i>
                            Experience
                        </button>
                    </div>
                    <div class="col-md-2 mb-2">
                        <button type="button" class="btn btn-info w-100" onclick="navigateToPage('Publication.aspx')">
                            <i class="fas fa-book me-2"></i>
                            Publications
                        </button>
                    </div>
                    <div class="col-md-2 mb-2">
                        <button type="button" class="btn btn-warning w-100" onclick="navigateToPage('AreaofExpertise.aspx')">
                            <i class="fas fa-lightbulb me-2"></i>
                            Expertise
                        </button>
                    </div>
                    <div class="col-md-2 mb-2">
                        <button type="button" class="btn btn-secondary w-100" onclick="navigateToPage('UploadDocument.aspx')">
                            <i class="fas fa-file-alt me-2"></i>
                            Documents
                        </button>
                    </div>
                    <div class="col-md-2 mb-2">
                        <button type="button" class="btn btn-dark w-100" onclick="navigateToPage('TrainingProgram.aspx')">
                            <i class="fas fa-graduation-cap me-2"></i>
                            Training
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .dashboard-container {
            font-size: 14px;
            padding: 0;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container-fluid {
            padding: 0 20px;
        }

        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        /* Modern Header Styles */
        .modern-header {
            background: #ffffff;
            border-bottom: 1px solid #e9ecef;
            padding: 20px 0;
            margin-bottom: 24px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.04);
        }

        .main-title {
            font-size: 1.7rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 6px;
            line-height: 1.2;
        }

        .subtitle {
            font-size: 1rem;
            color: #6c757d;
            margin-bottom: 0;
            font-weight: 400;
        }

        .header-actions {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 24px;
        }

        .action-buttons {
            display: flex;
            gap: 12px;
        }

        .btn-modern {
            border-radius: 8px;
            font-weight: 600;
            padding: 12px 24px;
            font-size: 0.9rem;
            transition: all 0.2s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-modern.btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            box-shadow: 0 2px 8px rgba(0, 123, 255, 0.3);
        }

        .btn-modern.btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0, 123, 255, 0.4);
        }

        .btn-modern.btn-outline-primary {
            background: transparent;
            color: #007bff;
            border: 2px solid #007bff;
            padding: 10px 16px;
        }

        .btn-modern.btn-outline-primary:hover {
            background: #007bff;
            color: white;
            transform: translateY(-2px);
        }

        .profile-section {
            display: flex;
            align-items: center;
        }

        .profile-info {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 16px;
            background: #f8f9fa;
            border-radius: 12px;
            border: 1px solid #e9ecef;
        }

        .profile-details {
            text-align: right;
        }

        .profile-name {
            font-size: 0.9rem;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 2px;
        }

        .profile-role {
            font-size: 0.8rem;
            color: #6c757d;
        }

        .profile-avatar .avatar-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 2px solid #e9ecef;
        }

        /* Chart Card Styles */
        .chart-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border: 1px solid #e9ecef;
        }

        .chart-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .chart-header {
            padding: 10px 14px;
            background: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .chart-title {
            margin: 0;
            font-size: 0.9rem;
            font-weight: 600;
            color: #2c3e50;
        }

        .chart-actions {
            display: flex;
            gap: 5px;
        }

        .btn-chart-action {
            width: 28px;
            height: 28px;
            border: none;
            border-radius: 4px;
            background: #f8f9fa;
            color: #6c757d;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
        }

        .btn-chart-action.active {
            background: #007bff;
            color: white;
        }

        .btn-chart-action:hover {
            background: #e9ecef;
        }

        .btn-chart-action.active:hover {
            background: #0056b3;
        }

        .chart-body {
            padding: 14px;
        }

        .chart-container {
            position: relative;
            height: 180px;
            margin-bottom: 12px;
        }

        .chart-legend {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 5px 0;
        }

        .legend-color {
            width: 12px;
            height: 12px;
            border-radius: 3px;
        }

        .legend-label {
            flex: 1;
            font-size: 0.9rem;
            color: #666;
        }

        .legend-value {
            font-weight: 600;
            color: #333;
        }

        /* Mini Chart Cards */
        .mini-chart-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border: 1px solid #e9ecef;
        }

        .mini-chart-card:hover {
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .mini-chart-header {
            padding: 8px 12px;
            background: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }

        .mini-chart-title {
            margin: 0;
            font-size: 0.8rem;
            font-weight: 600;
            color: #2c3e50;
        }

        .mini-chart-body {
            padding: 12px;
        }

        .mini-chart-container {
            position: relative;
            height: 100px;
            margin-bottom: 8px;
        }

        .mini-chart-data {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .data-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 3px 0;
        }

        .data-label {
            font-size: 0.85rem;
            color: #666;
        }

        .data-value {
            font-weight: 600;
            color: #333;
        }

        /* Timeline Stats */
        .timeline-stats {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .timeline-stat {
            text-align: center;
        }

        .timeline-stat .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
            color: #007bff;
        }

        .timeline-stat .stat-label {
            font-size: 0.8rem;
            color: #666;
        }

        /* Chart Filters */
        .chart-filters .form-select {
            font-size: 0.85rem;
            padding: 5px 10px;
            border-radius: 6px;
        }

        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
            margin-bottom: 16px;
            transition: all 0.3s ease;
            background: #ffffff;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .summary-card {
            border: none;
            border-radius: 12px;
            transition: all 0.3s ease;
            margin-bottom: 16px;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
            overflow: hidden;
            position: relative;
        }

        .summary-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #007bff, #28a745, #ffc107, #dc3545);
        }

        .summary-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        .summary-card .card-body {
            padding: 16px;
            text-align: center;
        }

        .summary-icon {
            font-size: 1.8rem;
            margin-bottom: 12px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .summary-card .card-title {
            font-size: 0.95rem;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 12px;
        }

        .summary-stats {
            margin-bottom: 0;
        }

        .stat-value {
            display: block;
            font-size: 1.5rem;
            font-weight: 700;
            color: #007bff;
            margin-bottom: 4px;
        }

        .stat-label {
            font-size: 0.8rem;
            color: #6c757d;
            font-weight: 500;
        }

        .card-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-bottom: none;
            border-radius: 12px 12px 0 0 !important;
            padding: 16px 20px;
        }

        .card-header h4, .card-header h5 {
            margin: 0;
            color: #1a1a1a;
            font-size: 1rem;
            font-weight: 600;
        }

        .card-body {
            padding: 20px;
        }

        .progress {
            border-radius: 10px;
            background-color: #e9ecef;
        }

        .progress-bar {
            border-radius: 10px;
            transition: width 0.6s ease;
        }

        .progress-bar.bg-gradient {
            background: linear-gradient(45deg, #007bff, #28a745);
        }

        .btn {
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            padding: 12px 24px;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 0.85rem;
            border-radius: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }

        .completion-item {
            margin-bottom: 20px;
        }

        .badge {
            font-size: 0.8rem;
            padding: 6px 10px;
        }

        .overall-progress {
            margin: 20px 0;
        }

        .display-6 {
            font-size: 2rem;
        }

        .activity-item {
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .activity-text {
            flex: 1;
        }

        .activity-time {
            font-size: 0.8rem;
            color: #6c757d;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 0;
            }
            
            .container-fluid {
                padding: 0 16px;
            }
            
            .modern-header {
                padding: 14px 0;
                margin-bottom: 20px;
            }
            
            .main-title {
                font-size: 1.4rem;
            }
            
            .subtitle {
                font-size: 0.85rem;
            }
            
            .header-actions {
                flex-direction: column;
                gap: 12px;
                align-items: stretch;
            }
            
            .action-buttons {
                justify-content: center;
            }
            
            .profile-info {
                justify-content: center;
            }
            
            .summary-card .card-body {
                padding: 14px;
            }
            
            .stat-value {
                font-size: 1.3rem;
            }
            
            .card-body {
                padding: 16px;
            }
            
            .card-header {
                padding: 12px 16px;
            }
            
            .chart-container {
                height: 160px;
            }
            
            .mini-chart-container {
                height: 90px;
            }
            
            .btn {
                font-size: 0.8rem;
                padding: 8px 16px;
            }
        }

        /* Loading Animation */
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        .loading {
            animation: pulse 1.5s ease-in-out infinite;
        }
    </style>

    <!-- Chart.js Library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script>
        // Chart instances
        let profileCompletionChart, activityTimelineChart, publicationsChart, experienceChart, expertiseChart;

        $(document).ready(function () {
            // Initialize charts
            initializeCharts();
            
            // Load dashboard data on page load
            loadDashboardData();

            // Refresh button click handler
            $('#btnRefreshDashboard').click(function () {
                $(this).prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Refreshing...');
                loadDashboardData();
                setTimeout(() => {
                    $(this).prop('disabled', false).html('<i class="fas fa-sync-alt me-2"></i>Refresh Data');
                }, 2000);
            });

            // Chart action buttons
            $('.btn-chart-action').click(function () {
                $('.btn-chart-action').removeClass('active');
                $(this).addClass('active');
                var chartType = $(this).data('chart');
                updateProfileCompletionChart(chartType);
            });

            // Timeline filter change
            $('#timelineFilter').change(function () {
                updateActivityTimelineChart($(this).val());
            });
        });

        function initializeCharts() {
            // Profile Completion Chart
            const profileCtx = document.getElementById('profileCompletionChart').getContext('2d');
            profileCompletionChart = new Chart(profileCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Personal Details', 'Experience', 'Publications', 'Expertise', 'Documents'],
                    datasets: [{
                        data: [85, 70, 60, 50, 100],
                        backgroundColor: [
                            '#007bff',
                            '#28a745',
                            '#17a2b8',
                            '#ffc107',
                            '#6c757d'
                        ],
                        borderWidth: 0,
                        hoverOffset: 10
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    cutout: '60%'
                }
            });

            // Activity Timeline Chart
            const timelineCtx = document.getElementById('activityTimelineChart').getContext('2d');
            activityTimelineChart = new Chart(timelineCtx, {
                type: 'line',
                data: {
                    labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                    datasets: [{
                        label: 'Activities',
                        data: [8, 12, 15, 12],
                        borderColor: '#007bff',
                        backgroundColor: 'rgba(0, 123, 255, 0.1)',
                        borderWidth: 3,
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: '#007bff',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0,0,0,0.1)'
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });

            // Publications Chart
            const pubCtx = document.getElementById('publicationsChart').getContext('2d');
            publicationsChart = new Chart(pubCtx, {
                type: 'pie',
                data: {
                    labels: ['Journal Articles', 'Conference Papers', 'Book Chapters'],
                    datasets: [{
                        data: [8, 3, 1],
                        backgroundColor: ['#007bff', '#28a745', '#ffc107'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });

            // Experience Chart
            const expCtx = document.getElementById('experienceChart').getContext('2d');
            experienceChart = new Chart(expCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Teaching', 'Industry', 'Research'],
                    datasets: [{
                        data: [4, 2, 1],
                        backgroundColor: ['#28a745', '#17a2b8', '#ffc107'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    cutout: '70%'
                }
            });

            // Expertise Chart
            const expChrtCtx = document.getElementById('expertiseChart').getContext('2d');
            expertiseChart = new Chart(expChrtCtx, {
                type: 'bar',
                data: {
                    labels: ['Expert', 'Advanced', 'Intermediate'],
                    datasets: [{
                        data: [2, 2, 1],
                        backgroundColor: ['#dc3545', '#ffc107', '#28a745'],
                        borderRadius: 8,
                        borderSkipped: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            display: false
                        },
                        x: {
                            display: false
                        }
                    }
                }
            });
        }

        function updateProfileCompletionChart(chartType) {
            if (chartType === 'pie') {
                profileCompletionChart.config.type = 'doughnut';
                profileCompletionChart.config.options.cutout = '60%';
            } else {
                profileCompletionChart.config.type = 'bar';
                profileCompletionChart.config.options.cutout = 0;
                profileCompletionChart.config.options.scales = {
                    y: {
                        beginAtZero: true,
                        max: 100
                    }
                };
            }
            profileCompletionChart.update();
        }

        function updateActivityTimelineChart(days) {
            var data, labels;
            if (days === '7') {
                labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                data = [2, 3, 1, 4, 2, 1, 1];
            } else if (days === '30') {
                labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                data = [8, 12, 15, 12];
            } else {
                labels = ['Month 1', 'Month 2', 'Month 3'];
                data = [47, 52, 38];
            }
            
            activityTimelineChart.data.labels = labels;
            activityTimelineChart.data.datasets[0].data = data;
            activityTimelineChart.update();
        }

        function loadDashboardData() {
            // Load data for all sections
            loadPersonalDetailsSummary();
            loadExperienceDetailsSummary();
            loadPublicationsSummary();
            loadExpertiseSummary();
            loadDocumentsSummary();
            loadTrainingSummary();
            loadCoursesSummary();
            loadRecentActivity();
            calculateOverallCompletion();
        }

        function loadPersonalDetailsSummary() {
            // Dummy data for Personal Details
            setTimeout(function () {
                var completion = 85; // 85% completion
                
                $('#personalDetailsStatus').text(completion + '%');
                $('#personalDetailsProgress').css('width', completion + '%');
                $('#personalCompletionBadge').text(completion + '%');
                $('#personalCompletionBar').css('width', completion + '%');
            }, 500);
        }

        function loadExperienceDetailsSummary() {
            // Dummy data for Experience Details
            setTimeout(function () {
                var count = 7; // 7 experience records
                
                $('#experienceDetailsStatus').text(count);
                $('#experienceDetailsProgress').css('width', Math.min(count * 10, 100) + '%');
                $('#experienceCompletionBadge').text(count);
                $('#experienceCompletionBar').css('width', Math.min(count * 10, 100) + '%');
            }, 600);
        }

        function loadPublicationsSummary() {
            // Dummy data for Publications
            setTimeout(function () {
                var count = 12; // 12 publications
                
                $('#publicationsStatus').text(count);
                $('#publicationsProgress').css('width', Math.min(count * 5, 100) + '%');
                $('#publicationsCompletionBadge').text(count);
                $('#publicationsCompletionBar').css('width', Math.min(count * 5, 100) + '%');
            }, 700);
        }

        function loadExpertiseSummary() {
            // Dummy data for Expertise
            setTimeout(function () {
                var count = 5; // 5 expertise areas
                
                $('#expertiseStatus').text(count);
                $('#expertiseProgress').css('width', Math.min(count * 10, 100) + '%');
                $('#expertiseCompletionBadge').text(count);
                $('#expertiseCompletionBar').css('width', Math.min(count * 10, 100) + '%');
            }, 800);
        }

        function loadDocumentsSummary() {
            // Dummy data for Documents
            setTimeout(function () {
                var count = 8; // 8 documents uploaded
                
                $('#documentsStatus').text(count);
                $('#documentsProgress').css('width', Math.min(count * 15, 100) + '%');
                $('#documentsCompletionBadge').text(count);
                $('#documentsCompletionBar').css('width', Math.min(count * 15, 100) + '%');
            }, 900);
        }

        function loadTrainingSummary() {
            // Dummy data for Training
            setTimeout(function () {
                var count = 6; // 6 training programs
                
                $('#trainingStatus').text(count);
                $('#trainingProgress').css('width', Math.min(count * 10, 100) + '%');
            }, 1000);
        }

        function loadCoursesSummary() {
            // Dummy data for Courses
            setTimeout(function () {
                var count = 15; // 15 courses taught
                
                $('#coursesStatus').text(count);
                $('#coursesProgress').css('width', Math.min(count * 5, 100) + '%');
            }, 1100);
        }

        function loadRecentActivity() {
            // Dummy data for Recent Activity
            setTimeout(function () {
                var activities = [
                    {
                        title: 'Updated Experience Details',
                        time: '2 hours ago',
                        type: 'success',
                        icon: 'briefcase'
                    },
                    {
                        title: 'Added New Publication',
                        time: '1 day ago',
                        type: 'info',
                        icon: 'book'
                    },
                    {
                        title: 'Uploaded Document',
                        time: '2 days ago',
                        type: 'secondary',
                        icon: 'file-alt'
                    },
                    {
                        title: 'Completed Training Program',
                        time: '3 days ago',
                        type: 'dark',
                        icon: 'graduation-cap'
                    },
                    {
                        title: 'Added Expertise Area',
                        time: '1 week ago',
                        type: 'warning',
                        icon: 'lightbulb'
                    }
                ];
                
                displayRecentActivity(activities);
            }, 1200);
        }

        function displayRecentActivity(activities) {
            var html = '';
            if (activities && activities.length > 0) {
                activities.forEach(function (activity) {
                    html += `
                        <div class="activity-item d-flex align-items-center">
                            <div class="activity-icon bg-${activity.type || 'primary'}">
                                <i class="fas fa-${activity.icon || 'circle'} text-white"></i>
                            </div>
                            <div class="activity-text">
                                <div class="fw-bold">${activity.title || 'Activity'}</div>
                                <div class="activity-time">${activity.time || 'Recently'}</div>
                            </div>
                        </div>
                    `;
                });
            } else {
                html = `
                    <div class="text-center text-muted py-3">
                        <i class="fas fa-info-circle me-2"></i>
                        No recent activity found
                    </div>
                `;
            }
            $('#recentActivityList').html(html);
        }

        function calculateOverallCompletion() {
            // Calculate overall completion based on all sections
            setTimeout(function () {
                var personalCompletion = parseInt($('#personalCompletionBadge').text()) || 0;
                var experienceCompletion = parseInt($('#experienceCompletionBadge').text()) || 0;
                var publicationsCompletion = parseInt($('#publicationsCompletionBadge').text()) || 0;
                var expertiseCompletion = parseInt($('#expertiseCompletionBadge').text()) || 0;
                var documentsCompletion = parseInt($('#documentsCompletionBadge').text()) || 0;

                // Weighted calculation
                var overallCompletion = Math.round(
                    (personalCompletion * 0.3) + 
                    (Math.min(experienceCompletion * 10, 100) * 0.2) + 
                    (Math.min(publicationsCompletion * 5, 100) * 0.2) + 
                    (Math.min(expertiseCompletion * 10, 100) * 0.15) + 
                    (Math.min(documentsCompletion * 15, 100) * 0.15)
                );

                // Update overall completion display
                $('#overallCompletion').text(overallCompletion + '%');
                $('#overallCompletionBar').css('width', overallCompletion + '%');
                
                
                // Update chart legend values
                $('#piePersonal').text(personalCompletion + '%');
                $('#pieExperience').text(Math.min(experienceCompletion * 10, 100) + '%');
                $('#piePublications').text(Math.min(publicationsCompletion * 5, 100) + '%');
                $('#pieExpertise').text(Math.min(expertiseCompletion * 10, 100) + '%');
                $('#pieDocuments').text(Math.min(documentsCompletion * 15, 100) + '%');
                
                // Update charts with new data
                if (profileCompletionChart) {
                    profileCompletionChart.data.datasets[0].data = [
                        personalCompletion, 
                        Math.min(experienceCompletion * 10, 100), 
                        Math.min(publicationsCompletion * 5, 100), 
                        Math.min(expertiseCompletion * 10, 100), 
                        Math.min(documentsCompletion * 15, 100)
                    ];
                    profileCompletionChart.update();
                }
            }, 1500);
        }

        function navigateToPage(pageName) {
            window.location.href = pageName;
        }

        // Auto-refresh every 5 minutes
        setInterval(function () {
            loadDashboardData();
        }, 300000);
    </script>
</asp:Content>

