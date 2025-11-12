<%@ Page Title="Course Wise Student Grade" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_wise_grade.aspx.cs" Inherits="Admin_Master_Student_wise_grade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/student_wise_grade.js?t=28082019" type="text/javascript"></script>

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
                <i class="icon-desktop"></i>Course Wise Student Grade
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">

        <div id="course_select" class="panel panel-default">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Course Selection</span></strong></div>
            <div style="padding: 15px;" id="div3">
                <div class="row" style="display:none;">
                    <div class="form-group col-md-4">
                       <div class="col-md-3" style="padding:0 0 0 0;">Semester :</div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-9" style="padding:0 0 0 0;">
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                       <div class="col-md-3" style="padding:0 0 0 0;">Year :</div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-9" style="padding:0 0 0 0;">
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="row" style="margin-top:15px;">
                    <div class="form-group col-md-4">
                       <div class="col-md-3" style="padding:0 0 0 0;">Course :</div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-9" style="padding:0 0 0 0;">
                            <select class="chosen-select" id="drcourses">
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-4">
                        <button class="btn btn-primary" type="button" id="btnRetrieve" onclick="retrieveClick()">
                                <i class="icon-plus"></i>&nbsp; Retrieve
                            </button>
                    </div>

                </div> 
            </div>
        </div>

        <div id="div_stud_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Student Grade Detail</span></strong>
            </div>
            
            <div> <%--class="panel-body"--%>
                <div id="DataList" style="display: none;">
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

    </div>

</asp:Content>

