<%@ Page Title="CEPT - REPORT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Faculty_report.aspx.cs" Inherits="Admin_Report_Faculty_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=18112021" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment(); ///Returned By Ananth ///
            bindprogrammedata();  ///Returned By Ananth ///
            bindproglevel();   ///Returned By Ananth ///

            $('#btnreterive').on('click', function () {
                get_instructor_details();
                return false;
            });

            return false;
        });
    </script>
    <style>
        #DataList .span6 
        {
            width:513px;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Faculty Teaching Details
            </h1>
        </div>
        <div>
            <div class="panel panel-default ">
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
                                Year of Allocation
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                             <td>
                                Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Program 
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                            <td>
                                Program Level
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel">
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

            <div id="div_faculty_list" class="panel panel-default" style="display: none;">
                <div class="panel-heading">
                    <strong>Faculty Details</strong>
                </div>
                <div>
                    <div id="DataList" style="display: none; overflow:auto;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="tab-content">--%>
        <%--</div>--%>
    </div>
     <asp:HiddenField ID="hdn_user_type" runat="server" ClientIDMode="Static" />
</asp:Content>

