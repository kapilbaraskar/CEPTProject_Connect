<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="feedback_raw_data_report.aspx.cs" Inherits="Admin_Report_feedback_raw_data_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/feedback_report.js" type="text/javascript"></script>
    <script type="text/javascript">



        $(document).ready(function () {
            bindcoursetype();
         
            $('#btnreterive').on('click', function () {


                Get_feedback_raw_data();

                return false;
            });

            //        $('#drpsemester').on('change', function () {
            //            if ($('#drpsemester').val() != '') {
            //                bind_sem_course();
            //            }
            //        });



        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Feedback Raw Data
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <%--  <tr>
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
                        </tr>--%>
                        <tr>
                            <td>Feedback Type:
                            </td>
                            <td>
                                <select class="chosen-select" id="drp_feedback_type">
                                    <option value="course">Course</option>
                                    <option value="instructor">Instructor</option>
                                </select>
                            </td>
                            <td>Course Type :
                            </td>
                            <td>
                                <select class="chosen-select" id="drp_course_type">

                                </select>
                            </td>
                             <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                        <tr>
                           
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
                    <tfoot style="background-color: #f3f3f3">
                        <tr>
                            <th>Total:
                            </th>
                            <th style="text-align: left"></th>
                            <th style="text-align: left"></th>
                            <th style="text-align: left"></th>
                            <th style="text-align: left"></th>
                            <th style="text-align: left"></th>
                            <th style="text-align: left"></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</asp:Content>

