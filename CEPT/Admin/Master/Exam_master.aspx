<%@ Page Title="Exam Master" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="Exam_master.aspx.cs" Inherits="Admin_Master_Exam_master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .marg-btm1
        {
            margin-bottom:0px;
        }
        .pad-left
        {
            padding-left: 0px;
        }
        .txtwidth
        {
            <%--width:100%;    --%>
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Add New Exam
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">New Exam Detail</span> </strong>
            </div>
            <div class="panel-body">
                
                <div class="row">
                    <div class="form-group col-sm-2 col-xs-5">
                        Exam Code :
                    </div>
                    <div class="form-group col-sm-3 col-xs-6 pad-left">
                        <input type="text" id="txt_examcode" class="marg-btm txtwidth col-lg-10 col-sm-12"/>
                    </div>
                    <div class="form-group col-sm-2 col-xs-5">
                        Exam Title :
                    </div>
                    <div class="form-group col-sm-3 col-xs-6 pad-left">                        
                        <input type="text" id="txt_examtitle" class="marg-btm txtwidth col-lg-10 col-sm-12" />
                    </div>
                    <div class="form-group col-sm-2 col-xs-5">
                        Exam Type :
                    </div>
                    <div class="form-group col-sm-3 col-xs-6 pad-left">                 
                        <input type="text" id="txt_examtype" class="marg-btm txtwidth col-lg-10 col-sm-12" />
                    </div>
                    <div class="form-group col-sm-2 col-xs-5">
                        Weightage :
                    </div>
                    <div class="form-group col-sm-3 col-xs-6 pad-left">                 
                        <input type="text" id="txt_weightage" class="marg-btm txtwidth col-lg-10 col-sm-12" />
                    </div>
                    <div class="form-group col-sm-2 col-xs-5">
                        Required Marks :
                    </div>
                    <div class="form-group col-sm-3 col-xs-6 pad-left">                 
                        <input type="text" id="txt_requiredmarks" class="marg-btm txtwidth col-lg-10 col-sm-12" />
                    </div>
                    <div class="form-group col-sm-2 col-xs-5">
                        Total(Out of) Marks :
                    </div>
                    <div class="form-group col-sm-3 col-xs-6 pad-left">
                        <input type="text" id="txt_total_outof_marks" class="marg-btm txtwidth col-lg-10 col-sm-12" />
                    </div>
                </div>

                <div class="row" style="margin-top:10px;">
                    <div class="form-group col-sm-2">
                        Exam Description :
                    </div>
                    <div class="form-group col-lg-8 col-sm-9 pad-left">
                        <textarea id="txt_examdesc" style="width:100%"" rows="6" cols="50" name="address"></textarea>
                    </div>
                </div>


                <%--
                <div class="row">
                    <div class="form-group col-sm-2 col-xs-5">
                        Exam Code :
                    </div>
                    <div class="form-group col-lg-2 col-sm-3 col-xs-6 pad-left">
                        <input type="text" id="txt_examcode" class="marg-btm txtwidth"/>
                    </div>
                    <div class="form-group col-lg-offset-1 col-sm-2 col-xs-5">
                        Exam Title :
                    </div>
                    <div class="form-group col-lg-2 col-sm-3 col-xs-6 pad-left">                        
                        <input type="text" id="txt_examtitle" class="marg-btm txtwidth" />
                    </div>
                    <div class="form-group col-sm-2 col-xs-5">
                        Exam Type :
                    </div>
                    <div class="form-group col-lg-2 col-sm-3 col-xs-6 pad-left">                 
                        <input type="text" id="txt_examtype" class="marg-btm txtwidth" />
                    </div>
                    <div class="form-group col-lg-offset-1 col-sm-2 col-xs-5">
                        Weightage :
                    </div>
                    <div class="form-group col-lg-2 col-sm-3 col-xs-6 pad-left">                 
                        <input type="text" id="txt_weightage" class="marg-btm txtwidth" />
                    </div>
                    <div class="form-group col-sm-2 col-xs-5">
                        Required Marks :
                    </div>
                    <div class="form-group col-lg-2 col-sm-3 col-xs-6 pad-left">                 
                        <input type="text" id="txt_requiredmarks" class="marg-btm txtwidth" />
                    </div>
                    <div class="form-group col-lg-offset-1 col-sm-2 col-xs-5">
                        Total(Out of) Marks :
                    </div>
                    <div class="form-group col-lg-2 col-sm-3 col-xs-6 pad-left">                        
                        <input type="text" id="txt_total_outof_marks" class="marg-btm txtwidth" />
                    </div>
                </div>

--%>
            </div>
        </div>
    </div>
</asp:Content>
