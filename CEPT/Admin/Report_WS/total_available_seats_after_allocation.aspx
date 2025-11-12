<%@ Page Title="CEPT-Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="total_available_seats_after_allocation.aspx.cs" Inherits="Admin_Report_total_available_seats_after_allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>
        <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
     <script type="text/javascript">


         $(document).ready(function () {

             bind_ws_semdata();
             bindyeardata_for_cross_reg();
             // bindyeardata();

             $('#btnreterive').on('click', function () {

                 total_available_seats_after_allocation();

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
                <i class="icon-desktop"></i> Total Available seats after allocation
            </h1>
        </div>
        </div>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Filter Criteria </strong>
                </div>
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
                            <%-- <td>
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>--%>
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
                    <strong>Total Available Seats After Allocation </strong>
                </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" width="100%" class="display table table-striped table-bordered table-hover">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    
</asp:Content>
