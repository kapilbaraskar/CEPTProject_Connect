<%@ Page Title="Feedback Report- CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="feedback_receipt_report.aspx.cs" Inherits="Admin_Report_feedback_receipt_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../../Js/feedback_report.js?t=28082019" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style>
        #example {
        width:100% !important;
        }
    </style>
<script type="text/javascript">
    
    $(document).ready(function () {
        bindsemdata();
        binddepartment();
     //   bindprogrammedata();
        bindproglevel();
        bindyeardata_for_cross_reg();

        $('#btnreterive').on('click', function () {


            get_feedback_receipt_data();

            return false;
        });

        $('#drpsemester').on('change', function () {
            if ($('#drpsemester').val() != '') {

                if ($('#drpyear').val() != '') {
                    bind_sem_course();
                }

            }
        });


        $('#drpyear').on('change', function () {
            if ($('#drpyear').val() != '') {

                if ($('#drpsemester').val() != '') {
                    bind_sem_course();
                }

            }
        });

      

    });
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row-fluid">
        <div class="page-header position-relative">
         
            <h1>
                <i class="icon-desktop"></i> Feedback Receipt Report
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester of Allocation:
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                          

                              <td>
                                 Year of Allocation :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>

                              <td>
                                 Course:
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses">
                                </select>
                            </td>
                            
                        </tr>
                        <tr>
                           
                              <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                            <td>
                               Program Level :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel" />
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
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</asp:Content>

