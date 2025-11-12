<%@ Page Title="" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="Test1.aspx.cs" Inherits="Admin_Master_Test1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <!-- Main Content -->
    <main class="col-12 px-md-2"> 
      <div class="tab-content">
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

       
      </div>
    </main>
</asp:Content>

