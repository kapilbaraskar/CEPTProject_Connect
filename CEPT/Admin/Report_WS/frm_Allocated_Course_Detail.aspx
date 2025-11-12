<%@ Page Title="Registered Report - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="frm_Allocated_Course_Detail.aspx.cs" Inherits="Admin_Report_frm_Allocated_Course_Detail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>

       <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
  <script type="text/javascript">
      $(document).ready(function () {

          bindyeardata_for_cross_reg();
          bind_ws_semdata();
          binddepartment()

          $('#btnreterive').on('click', function () {

              registered_course_detail();

              return false;

          });

          return false;

      });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Registered Courses Detail
            </h1>
        </div>
     </div>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Filter Criteria</strong>
                </div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year of allocation
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <td>
                               Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
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
            <div id="DataList" class="panel panel-default" style="display: none">
                <div class="panel-heading">
                    <strong>Registered Courses Detail</strong>
                </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            
        </div>
    
    
</asp:Content>

