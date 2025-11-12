<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="frm_financial_reports_course_wise_SW.aspx.cs" Inherits="Admin_Report_frm_financial_reports_course_wise_SW" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report_SW.js" type="text/javascript"></script>
  <script type="text/javascript">
      $(document).ready(function () {

          bindyeardata_for_cross_reg();
          bindsemdata();
          binddepartment();

          $('#btnreterive').on('click', function () {

              financial_report_course_wise_data();

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
                <i class="icon-desktop"></i> Finance Report for Summer/Winter
            </h1>
        </div>
        <div>
            <div>
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
            <div id="DataList" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            
        </div>
    
    </div>
</asp:Content>