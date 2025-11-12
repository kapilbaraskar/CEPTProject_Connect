<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="MidtermGradeRange.aspx.cs" Inherits="Admin_Master_MidtermGradeRange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/MidtermGradeRange.js?t=02062022" type="text/javascript"></script><%--30102018--%><%--12022021--%><%--08102021--%>
    <script src="../../Js/admin_report_midterm.js?08102021" type="text/javascript"></script>

    <%--<script type="text/javascript" src="http://oss.sheetjs.com/js-xlsx/xlsx.core.min.js"></script>
    <script type="text/javascript" src="http://sheetjs.com/demos/Blob.js"></script>
    <script type="text/javascript" src="http://sheetjs.com/demos/FileSaver.js"></script>--%>

    <%--<script type="text/javascript" src="../../Js/js2/xlsx.core.min.js"></script>
    <script type="text/javascript" src="../../Js/js2/Blob.js"></script>
    <script type="text/javascript" src="../../Js/js2/FileSaver.js"></script>
    <script src="../../Js/js2/tableexport.min.js" type="text/javascript"></script>--%>

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">    
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Course Wise Grade Range
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <div>
                     <div style="text-align: -webkit-center;">
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
                                    Year of allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                  <td class="cls_dept_prog">Department
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                            </tr>
                             <tr>
                                <td>Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                 <td>
                               Program Level
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel" />
                            </td>
                                <td style="display:none;">
                                </td>
                                <td style="display:none;">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>Typology Group
                                </td>
                                <td>
                                    <select class="chosen-select" id="drp_typology_group">
                                    <option value="">-- Select Typology Group --</option>
                                </select>
                                </td>
                                 <td>
                               Course Typology
                            </td>
                            <td>
                                <select class="chosen-select" id="drptypology">
                                </select>
                            </td>
                                <td style="display: none" id="typ_sub_group">Course Sub Category
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsubtypology" style="display: none">
                                    <option value="">-- Please Select --</option>
                                </select> 
                                </td>
                            </tr>
                            <tr>
                                 <td colspan="8" style="text-align:center;">
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    
        <div id="div_course_list" class="panel panel-default" style="display:none;">            
            <div class="panel-heading">
                <strong>Calculated Grade Range</strong>
                <span style="float:right;">
                    <input type="button" class="btn btn-primary" value="Submit Grade" onclick="Submit_grade_range()" style="height: 40px;margin-top: -10px;"/>
                </span>
            </div>

            <div>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

