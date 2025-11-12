<%@ Page Title="CEPT - Report" Language="C#" MasterPageFile="~/MasterPageDesign.master"  AutoEventWireup="true" CodeFile="Frm_Last_Sem_allocate_course.aspx.cs" Inherits="Student_Frm_Last_Sem_allocate_course" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script src="../Js/last_semester_course.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row-fluid">
        <div class="page-header position-relative" >
            <h1>
                <i class="icon-desktop"></i> Your Last Allocate Course List
            </h1>
        </div>
        <div>
            
            <div id="DataList" style="display: none; margin-top:20px">
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

