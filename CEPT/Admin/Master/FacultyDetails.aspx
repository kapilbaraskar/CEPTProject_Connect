<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FacultyDetails.aspx.cs" Inherits="Admin_Master_FacultyDetails" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Faculty Details</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
      font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", "Liberation Sans", sans-serif;
    }
    .sidebar {
      min-height: 100vh;
      background-color: #f5f5f5;
    }
    /* Match Bootstrap navbar link sizing */
    .sidebar .nav-link {
      color: #212529bf;
      margin: 5px 0;
      font-size: 1rem;          /* same as .navbar .nav-link */
      line-height: 1.5;
      padding: .5rem .75rem;    /* same vertical rhythm */
      font-weight: 500;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .sidebar .nav-link:hover { background-color: rgba(255,255,255,.08); }
    .sidebar .nav-link.active { background-color: #ddd; border-radius: 5px; }
    .form-section { display: none; }
    .form-section.active { display: block; }

    /* Sidebar custom scrollbars (Chromium/Safari/Edge) */
    .sidebar {
      scrollbar-width: thin;              /* Firefox */
      scrollbar-color: #c7cbd1 transparent;
    }
    .sidebar::-webkit-scrollbar {
      width: 10px;
    }
    .sidebar::-webkit-scrollbar-track {
      background: transparent;            /* or #f5f5f5 to match sidebar */
      border-radius: 8px;
    }
    .sidebar::-webkit-scrollbar-thumb {
      background: linear-gradient(180deg,#d8dbe0,#c7cbd1);
      border-radius: 8px;
      border: 2px solid transparent;      /* gives a “pill” with gap */
      background-clip: padding-box;
    }
    .sidebar::-webkit-scrollbar-thumb:hover {
      background: linear-gradient(180deg,#cfd3d9,#babfc6);
    }

    /* Optional: show a subtle fade at bottom to hint scroll */
    .sidebar {
      background:
        linear-gradient(#f5f5f5 30%, rgba(245,245,245,0)) top / 100% 18px no-repeat,
        linear-gradient(rgba(245,245,245,0), #f5f5f5 70%) bottom / 100% 18px no-repeat,
        radial-gradient(farthest-side at 50% 0, rgba(0,0,0,.06),rgba(0,0,0,0)) top / 100% 12px no-repeat,
        radial-gradient(farthest-side at 50% 100%, rgba(0,0,0,.06),rgba(0,0,0,0)) bottom / 100% 12px no-repeat,
        #f5f5f5; /* base sidebar bg */
      background-attachment: local, local, scroll, scroll, scroll;
      overscroll-behavior: contain;
    }

    /* Default: single line + ellipsis */
    .sidebar .nav-link{
      display:block;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      max-width: 78%;
    }

    /* On hover/focus/active: allow wrapping to show full text */
    .sidebar .nav-link:hover,
    .sidebar .nav-link:focus,
    .sidebar .nav-link.active{
      white-space: normal;        /* wrap lines */
      word-break: break-word;     /* break long words */
      line-height: 1.35;
    }

    /* Smaller, denser left menu */
    .sidebar .nav-link{
      font-size: .875rem;   /* ~14px */
      line-height: 1.25;
      padding: .3rem .5rem;
    }
    .sidebar .nav .nav-item + .nav-item { margin-top: 2px; } /* keep gaps tight */

    /* Left sidebar bottom padding */
    .sidebar{
      padding-bottom: 16px;   /* adjust as needed */
    }

    /* If the UL itself needs spacing, add this too */
    .sidebar .nav{
      margin-bottom: 12px;
    }

    /* Remove hover effect on sidebar links */
    .sidebar .nav-link:hover,
    .sidebar .nav-link:focus {
      background-color: transparent !important;
      color: inherit !important;
      text-decoration: none;
    }

    /* Keep active styling as-is (adjust if needed) */
    .sidebar .nav-link.active {
      /* your existing active styles */
    }

    /* No visual change on hover/focus */
    .sidebar .nav-link:hover,
    .sidebar .nav-link:focus{
      background-color: transparent !important;
      color: inherit !important;
      text-decoration: none;
      white-space: nowrap;        /* keep truncation stable */
    }

    /* Only the active item looks selected */
    .sidebar .nav-link.active{
      background-color:#e7f0ff;
      color:#0d6efd;
      border-radius:5px;
      font-weight:600;
    }
    /* active item */
    .sidebar .nav-link.active{
      background-color: #e7f0ff;   /* subtle blue */
      color: #0d6efd;
      border-radius: 6px;
      font-weight: 600;
      position: relative;
    }
    /* left accent bar */
    .sidebar .nav-link.active::before{
      content:"";
      position:absolute; left:0; top:8px; bottom:8px;
      width:4px; border-radius:4px;
      background:#0d6efd;
    }
    #menuTabs .nav-link { font-weight: 500; }
    #menuTabs .nav-link.active { background-color:#0d6efd; color:#fff; }
    #menuTabs { flex-wrap: wrap; gap: .25rem; } /* allow wrapping instead of scroll */
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <!-- Horizontal Top Menu -->
    <div class="col-12">
      <nav class="bg-light border-bottom p-2">
        <ul class="nav nav-tabs flex-wrap" id="menuTabs">
          <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" data-bs-target="#personal">Personal</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#contact">Contact</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#education">Education</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#experience">Experience</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#bank">Bank</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#expertise">Expertise</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#courses">Courses</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#publication">Publication</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#conferences">Conferences</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#research">Research</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#other_research">Other Research</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#awards">Awards</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#training">Training</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#affiliations">Affiliations</a></li>
          <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" data-bs-target="#social">Social</a></li>
        </ul>
      </nav>
    </div>

    <!-- Main Content -->
    <main class="col-12 px-md-4 py-4">
      <div class="tab-content pt-3">
        <!-- Personal Details -->
        <div id="personal" class="form-section tab-pane fade show active">
          <div class="card shadow-sm mb-4">
            <div class="card-header style="background-color: #f5f5f5;border-color: #ddd;">
              <h5 class="mb-0">Personal Details</h5>
            </div>
            <div class="card-body row g-3">
              <div class="col-md-6">
                <label class="form-label">Full Name</label>
                <input type="text" class="form-control" placeholder="Enter full name">
              </div>
              <div class="col-md-3">
                <label class="form-label">Date of Birth</label>
                <input type="date" class="form-control">
              </div>
              <div class="col-md-3">
                <label class="form-label">Gender</label>
                <select class="form-select">
                  <option selected disabled>Choose...</option>
                  <option>Male</option>
                  <option>Female</option>
                  <option>Other</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" placeholder="Enter email">
              </div>
              <div class="col-md-6">
                <label class="form-label">Mobile Number</label>
                <input type="text" class="form-control" placeholder="Enter mobile number">
              </div>
              <div class="col-12">
                <label class="form-label">Address</label>
                <textarea class="form-control" rows="2" placeholder="Enter address"></textarea>
              </div>
            </div>
          </div>
          <!-- Personal Details footer -->
          <div class="d-flex justify-content-end">
            <button class="btn btn-secondary me-2" disabled>Previous</button>
            <button class="btn btn-primary me-2" onclick="nextSection('education')">Next</button>
            <button class="btn btn-success">Save</button>
          </div>
        </div>

        <!-- Educational Details -->
        <div id="education" class="form-section tab-pane fade">
          <div class="card shadow-sm mb-4">
            <div class="card-header style="background-color: #f5f5f5;border-color: #ddd;">
              <h5 class="mb-0">Educational Details</h5>
            </div>
            <div class="card-body row g-3">
              <div class="col-md-6">
                <label class="form-label">Highest Qualification</label>
                <input type="text" class="form-control" placeholder="e.g. Ph.D, M.Tech">
              </div>
              <div class="col-md-6">
                <label class="form-label">Specialization</label>
                <input type="text" class="form-control" placeholder="Enter specialization">
              </div>
              <div class="col-md-6">
                <label class="form-label">University/College</label>
                <input type="text" class="form-control" placeholder="Enter university name">
              </div>
              <div class="col-md-6">
                <label class="form-label">Year of Passing</label>
                <input type="number" class="form-control" placeholder="Enter year">
              </div>
            </div>
          </div>
          <!-- Educational Details footer -->
          <div class="d-flex justify-content-end">
            <button class="btn btn-secondary me-2" onclick="prevSection('personal')">Previous</button>
            <button class="btn btn-primary me-2" onclick="nextSection('other')">Next</button>
            <button class="btn btn-success">Save</button>
          </div>
        </div>

        <!-- Other Details -->
        <div id="other" class="form-section tab-pane fade">
          <div class="card shadow-sm mb-4">
            <div class="card-header style="background-color: #f5f5f5;border-color: #ddd;">
              <h5 class="mb-0">Other Details</h5>
            </div>
            <div class="card-body row g-3">
              <div class="col-md-6">
                <label class="form-label">Experience (Years)</label>
                <input type="number" class="form-control" placeholder="Enter years of experience">
              </div>
              <div class="col-md-6">
                <label class="form-label">Designation</label>
                <input type="text" class="form-control" placeholder="Enter designation">
              </div>
              <div class="col-md-12">
                <label class="form-label">Remarks</label>
                <textarea class="form-control" rows="2" placeholder="Enter remarks"></textarea>
              </div>
            </div>
          </div>
          <!-- Other Details footer -->
          <div class="d-flex justify-content-end">
            <button class="btn btn-secondary me-2" onclick="prevSection('education')">Previous</button>
            <button class="btn btn-success">Save</button>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<script>
  // Call this to switch tabs programmatically
  function showSection(id){
    const trigger = document.querySelector(`#menuTabs .nav-link[data-bs-target="#${id}"]`);
    if (!trigger) return;
    const tab = new bootstrap.Tab(trigger);
    tab.show();
    // removed auto-scroll to prevent any scrolling on activate
  }
  function nextSection(nextId){ showSection(nextId); }
  function prevSection(prevId){ showSection(prevId); }

  // Optional: set initial tab if none is active
  document.addEventListener('DOMContentLoaded', function(){
    const active = document.querySelector('#menuTabs .nav-link.active');
    if (!active) new bootstrap.Tab(document.querySelector('#menuTabs .nav-link')).show();
  });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
