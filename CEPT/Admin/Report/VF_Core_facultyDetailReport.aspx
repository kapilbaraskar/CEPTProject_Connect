<%@ Page Title="VF Core Faculty Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="VF_Core_facultyDetailReport.aspx.cs" 
    Inherits="Admin_Report_VF_Core_facultyDetailReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/VF_core_facultyreport.js?t=11072022" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

   
     <style>
        #example
        {
            width: 100% !important;
        }
    </style>
     <script type="text/javascript">
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindMemberType();
            $('#btnreterive').on('click', function () {

                get_instructor_details();

                return false;

            });
            return false;
        });
          </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="" style="background-color: White;">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> VF and Core Faculty Report
            </h1>
        </div>
        <div>
              <div class="panel panel-default">
            <div>
                <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                 Member Type
                            </td>
                            <td>
                                <select class="chosen-select" id="drmmtype">
                                </select>
                            </td>
                            <td>
                                Faculty/Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                            <td>
                                Semester
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            
                        </tr>
                      <tr>
                          <td>
                                Year 
                            </td>
                            <td>
                               <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                      </tr>
                    </table>
                </div>
            </div>
                  </div>
            <div id="DataList" style="display: none; overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
          
            
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</div>

    <style>
        body {
            overflow: auto;
        }

        #main-container {
            padding: 10px;
            width: max-content;
        }
    </style>

</asp:Content>

