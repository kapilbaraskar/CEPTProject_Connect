<%@ Page Title="Report - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Cross_Registration_PG_UG_Report.aspx.cs" Inherits="Admin_Report_Cross_Registration_PG_UG_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindsemdata();
            //    binddepartment()

            $('#btnreterive').on('click', function () {

                get_cross_reg_PG_UG_wise();

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

                <i class="icon-desktop"></i> Cross Registration Courses Between PG-UG
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
                                Year of Allocation :
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
            <div id="DataList" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="page-header position-relative" style="color: #2679b5">
                <h3>
                  <i class="icon-desktop"></i>  Cross Registration Credits Between PG-UG
                </h3>
            </div>
            <div id="DataList1" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="example1" class="display table table-striped table-bordered table-hover"
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

