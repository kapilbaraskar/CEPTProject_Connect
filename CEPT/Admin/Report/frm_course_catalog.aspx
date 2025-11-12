<%@ Page Title="Course Catalog - Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="frm_course_catalog.aspx.cs" Inherits="Admin_Report_frm_course_catalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=28082019" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            //  bindyeardata();
            bindsemdata();
            binddepartment();
            bindprogrammedata();
            bindproglevel();
            $('#btnreterive').on('click', function () {

                get_course_catalog_data();

                return false;

            });


            return false;

        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Catalog Report
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <%--<td>
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>--%>
                            <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Program :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog" />
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
            <div id="DataList_mycourse" style="display: none; overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example_mycourse" class="display table table-striped table-bordered table-hover"
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
