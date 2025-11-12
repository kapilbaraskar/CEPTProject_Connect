<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="pie_chart.aspx.cs" Inherits="Admin_Report_pie_chart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script src="ChartJs/canvasjs.min.js" type="text/javascript"></script>

   <%-- <script src="../../ChartJs/knockout-3.0.0.js" type="text/javascript"></script>
    <script src="../../ChartJs/globalize.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
    <%--<script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.0.3.min.js"></script>--%>
    <%--  <script type="text/javascript" src="https://cdn3.devexpress.com/jslib/13.2.9/js/dx.chartjs.js"></script>
    <script src="../../ChartJs/dx.chartjs.js" type="text/javascript"></script>--%>
    <script src="../../Js/chart_report.js" type="text/javascript"></script>
    <script type="text/javascript">

       
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Chart
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
                            <%-- <td>
                                 Course:
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses">
                                </select>
                            </td>--%>
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
                        <tr>
                            <%-- <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>--%>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="pieChartContainer" style="width: 500px; margin-top:10px">
            </div>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>



    <div class='row'><div class='col-md-12 col-sm-12 col-xs-12'>
<h4 style='text-align: center; height: 18px;'><span data-bind='visible:$root.ProgramType()=='PTM0001''>ADMISSION COMMITTEE FOR PROFESSIONAL COURSES</span> </h4>
 <img id='logo' src='../Images/logo.png" class="img-responsive' /> <h4 style='text-align: center" data-bind="text:$root.program_type_desc'></h4>
               
                
                <h4 style='text-align: center' data-bind='text:$root.program_faculty_desc'></h4>
                
                <p style='text-align: center'>KASTURBHAI LALBHAI CAMPUS, UNIVERSITY ROAD,</p>
                    
                <p style='text-align: center'>NAVRANGPURA, AHMEDABAD, 380009 (INDIA)</p>
                    
                <p class='small' style='text-align: center'>TEL : 079 26302452 / 26306765 / 26302740 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;FAX : 079 26302075</p>
                                     
                   
                <p class='small' style='text-align: center'>Website : http://www.cept.ac.in</p> </div>
                    
           
        </div>
        <div class='row'>
            <div class='col-md-12 col-sm-12 col-xs-12'>
                <h4 style='text-align: center'>
                    APPLICATION FORM : 2014 - 15</h4>
            </div>
        </div>
        <div class='row'>
            <div class='col-md-6 col-sm-6 col-xs-6'>
                <h5 >
                    APPLICATION FORM NO. : <span data-bind="text:$root.application_id"></span>
                </h5>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-6">
                <h5 style="text-align: center">
                    APPLICATION FEES : <span style="border-bottom: 1px solid black" data-bind='text:$root.amount'></span></h5>
            </div>
        </div>
</asp:Content>
