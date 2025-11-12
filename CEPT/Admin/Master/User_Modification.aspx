<%@ Page Title="Student Modification" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="User_Modification.aspx.cs" Inherits="Admin_Master_User_Modification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/user_modification.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Student Modification
            </h1>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Selection Criteria</span></strong></div>
            <div style="padding: 16px;">
                <div class="row" style="margin-left: 2px;">
                    <div class="col-md-1 col-sm-4" style="padding: 0 0 0 0;">
                        Department
                    </div>
                    <div class="col-md-3 col-sm-4" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drp_dept">
                        </select>
                    </div>
                    <div class="col-md-1" style="padding: 0 0 0 0;">
                        Programme
                    </div>
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drp_prog">
                        </select>
                    </div>
                    <div class="col-md-1" style="padding: 0 0 0 0;">
                        Year of Enrollment</div>
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drp_year">
                        </select>
                    </div>
                </div>
                <div class="row" style="margin-left: 2px;">
                    <div class="col-md-1" style="padding: 0 0 0 0;">
                        Student
                    </div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drpuser">
                        </select>
                    </div>
                    <div class="col-md-2" style="padding: 0 0 0 0;">
                        <button class="btn btn-primary" type="submit" id="btnreterive">
                            Retrieve
                        </button>
                        <input type="button" class="btn btn-primary" id="Clear" value="Clear"/>
                    </div>
                </div>
            </div>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
    <div id="divdetails" style="display: block">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Login Status</span></strong>
            </div>
            <div style="padding: 16px; margin-left: 2%;">
                <div class="row">
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Email Id:
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <%-- <span class="add-on"><i class="icon-envelope-alt"></i></span>--%>
                            <input type="text" id="txtemail" placeholder="Email" />
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Student Status :
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpavtice">
                                <option value="A">Active</option>
                                <option value="N">Deactive</option>
                            </select>
                            <input type="hidden" id="txt_usertype" placeholder="password" />
                            <%-- <input type="hidden" id="txt_userid" placeholder="password" />--%>
                            <input type="hidden" id="txt_prog_level_code" placeholder="password" />
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Login Status :
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drp_status">
                                <option value="A">Active</option>
                                <option value="N">Deactive</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Personal Details</span></strong></div>
            <div style="padding: 16px; margin-left: 2%;">
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Department
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpdepartment">
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Program
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Year
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Program Level
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drp_prog_level">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 1%">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Name(As per mark sheet)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_full_name" placeholder="Full Name" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Date of Birth (dd/mm/yyyy)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txtdob" placeholder="Date Of Birth" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Blood Group
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select id="txtbloodgrp">
                                <option value="0">Select Blood Group</option>
                                <option value="O+">O+</option>
                                <option value="O-">O-</option>
                                <option value="A+">A+</option>
                                <option value="A-">A-</option>
                                <option value="B+">B+</option>
                                <option value="B-">B-</option>
                                <option value="AB+">AB+</option>
                                <option value="AB-">AB-</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Gender
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select id="drpgender">
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            First Name
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_firstname" placeholder="First Name" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Middle Name
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_middelname" placeholder="Middle Name" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Last Name
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_Lastname" placeholder="Last Name" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Nationality
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txtnationality" placeholder="Nationality" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Category
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select id="drp_category">
                                <option value="OP">Open</option>
                                <option value="SC">SC</option>
                                <option value="ST">ST</option>
                                <option value="OB">OBC</option>
                                <option value="SE">SEBC</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-10 col-sm-4" style="padding: 0 0 0 0;">
                            Disability/ Physically Handicapped
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select id="drp_disability">
                                <option value="N">No</option>
                                <option value="Y">Yes</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-10 col-sm-4" style="padding: 0 0 0 0;">
                            Economically Backward(for TFW)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_economically_backward" placeholder="Economically Backward" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Code No.
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_userid" disabled />
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 1%;">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Father’s Name
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_father_name" placeholder=" Father’s Name" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Mother’s Name
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_mother_name" placeholder="Mother's Name" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Guardian’s Name
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_guardian_contact_name" placeholder="Guardian's Name" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Application no
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_enrollment_no" placeholder="Application No" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Contact Details</span></strong></div>
            <div style="padding: 16px; margin-left: 2%;">
                <div class="row">
                    <div class="col-md-2 col-sm-4" style="padding: 0 0 0 0;">
                        Permanent Address (with city code and state)
                    </div>
                    <div class="col-md-4 col-sm-4" style="padding: 0 0 0 0;">
                        <textarea id="txtperadd" rows="3" cols="50" name="address" style="width: 85%;"></textarea>
                    </div>
                    <div class="col-md-2 col-sm-4" style="padding: 0 0 0 0;">
                        Local Address (with city code and state)
                    </div>
                    <div class="col-md-4 col-sm-4" style="padding: 0 0 0 0;">
                        <textarea id="txtadd" rows="3" cols="70" name="address" style="width: 85%;"></textarea>
                    </div>
                </div>
                <div class="row" style="margin-top: 1%;">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Students Contact No
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_student_contact_no" placeholder="Student Contact No" maxlength="10"
                                onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Alternate Email Id
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txtaltemail" placeholder="Alternate Email" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Residence Phone no
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_residence_no" placeholder="Residence Phone no" maxlength="10"
                                onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Emergency Contact No:1
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txtmobileno" placeholder="Emergency Contact No:1" maxlength="10"
                                onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 1%;">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Emergency Contact No:2
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_emergency_contact_2" placeholder="Emergency Contact No:2"
                                maxlength="10" onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            Relationship with Emergency Contact
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_emergency_relationship" placeholder="Relationship with Emergency Contact" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Father’s Contact no
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_father_contact" placeholder="Father’s Contact no" maxlength="10"
                                onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Mother’s Contact no
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_mother_contact" placeholder="Mother’s Contact no" maxlength="10"
                                onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 1%;">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Guardian’s Contact no
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_guardian_contact" placeholder="Guardian’s Contact no"
                                maxlength="10" onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Father’s Email
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_father_email" placeholder="Father’s Email" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Mother’s Email
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_mother_email" placeholder="Mother’s Email" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Guardian’s Email
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_guardian_email" placeholder="Guardian’s Email" />
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 1%;">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            Date of Joining (for late arrival recod)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txtDOJ" placeholder="Date of Joining" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-12 col-sm-4" style="padding: 0 0 0 0;">
                            If registered for the the current semester
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_registered_current_sem" placeholder="If registered" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br />
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Medical Details</span></strong></div>
            <div style="padding: 16px; margin-left: 2%;">
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Height (Cms)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_height" placeholder="Heigh (Cms)" maxlength="5" onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Weight (Kgs)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_weight" placeholder="Weight (Kgs)" maxlength="5" onkeypress='return IsNumeric(event);' />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Color Blindness
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_blindness_color" placeholder="Color Blindness" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Color of the eye
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_eye_color" placeholder="Color of the eye" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Specific Identification Mark #1
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_identification_1" placeholder="Specific Identification Mark #1" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Specific Identification Mark #2
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_identification_2" placeholder="Specific Identification Mark #2" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Any Routine Health Complaint/s
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_routine_health_complain" placeholder="Any Routine Health Complaint/s" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Allergic to a Drug (if known)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_allergic_to_drug" placeholder="Allergic to a Drug (if known)" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Disability (If any)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_disability" placeholder="Disability (If any)" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Past History of any Major Illness
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_major_illness" placeholder="Past History of any Major Illness" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            TB/Typhoid/Asthma
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_tb_typhoid_asthama" placeholder="TB/Typhoid/Asthma" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            Any Major Injury &/or Operation
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_major_injury" placeholder="Any Major Injury &/or Operation" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Any major Prolonged illness
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_major_prolonged_illness" placeholder="Any major Prolonged illness" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Any other habits ie: smoking etc
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_other_habits" placeholder="Any other habits ie: smoking etc" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Irregular sleep pattern
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_irregular_sleep_pattern" placeholder="Irregular sleep pattern" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Dietary habits
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_dietary_habits" placeholder="Dietary habits" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            Vision Ability: normal/spectacles (If spectacles, then #nos in both eyes)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_vision_ability" placeholder=" Vision Ability" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            Any Major Dental Surgery, If so indicate the nature
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_major_dental_surgery" placeholder="Any Major Dental Surgery" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            &nbsp;
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            Insurance Card No
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_insurance_card_no" placeholder="Insurance Card No" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Family Health History</span></strong></div>
            <div style="padding: 16px; margin-left: 2%;">
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            High Blood Pressure
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_high_bp" placeholder="High Blood Pressure" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Diabetes
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_diabetes" placeholder="Diabetes" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Tuberculosis (T.B.)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_tuberculosis" placeholder="Tuberculosis" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Ischemia Heart Disease (I.H.D)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_ischemia_heart_disease" placeholder="Ischemia Heart Disease" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Thalassemia
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_thalassemia" placeholder="Thalassemia" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Other
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" id="txt_other" placeholder="Other" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="display: none">
            <div class="tabbable">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#InsertEditRace" data-toggle="tab"><b>Educational Detail</b></a>
                    </li>
                    <%--<li><a href="#ListRace"
    data-toggle="tab">Races List</a></li>--%>
                </ul>
                <div class="tab-content">
                    <div id="Div4" class="tab-pane active">
                        <div class="span4">
                            <div class="control-group">
                                <div class="control-group">
                                    <label class="control-label" for="txtaddress">
                                        Academic Program Enrolled Currently:
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txtacadamic" placeholder="Academic
    Program" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="txtemail">
                                        Name of the University / Institution:
                                    </label>
                                    <div class="controls">
                                        <div class="input-prepend">
                                            <input type="text" id="txtnou" placeholder="Name of
    University" />
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="txtaddress">
                                        Address of University / Institution:
                                    </label>
                                    <div class="controls">
                                        <textarea id="txtaddofuni" rows="3" cols="50" name="address"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <%--<div class="control-group"> <%-- <label
    class="control-label" for="txtmidname"> Middle Name : </label> <div class="controls">
    <input type="text" id="txtmidname" placeholder="Login Name" /> </div>--%>
                            <div class="control-group">
                                <label class="control-label" for="txtemail">
                                    Year of Enrollment (YYYY):
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <input type="text" id="txtyearofenro" placeholder="Enrollment" />
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtemail">
                                    Full Name OF Degree / Diplama:
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <input type="text" id="txtnod" placeholder="Name
    of Degree/Diploma" />
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtemail">
                                    Percentage/CGPA in Last Examination:
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <input type="text" id="txtmarks" placeholder="Marks" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="span3">
                            <div class="control-group">
                                <label class="control-label" for="txtmobile">
                                    Expected Year of Passing (YYYY):
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <input type="text" id="txtyop" placeholder="Year of Passing" />
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtphone">
                                    Professional Experience (In Years):
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <input type="text" id="txtprof_exp" placeholder="Experience" />
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtphone">
                                    How did you hear about this?
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <textarea id="txthere" rows="3" cols="50" name="address"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Education</span></strong></div>
            <div>
              <div class="row-fluid" id="dataList_instructor" style="margin-top: 15px; margin-bottom: 15px; width: 100%; display: block;">

                        <table class="data-table table table-bordered table-striped" border="0" id="tbleducation">
                            <thead>
                                <tr>
                                    <th>Degree Name
                                    </th>
                                    <th>Institution
                                    </th>
                                    <th>University</th>
                                    <th>Education Major Subject</th>
                                    <th>Year of Graduation</th>
                                    <th>Education Score</th>
                                    <th>Nata Id</th>
                                    <th>Nata Score</th>
                                    <th>Nata Second Score</th>

                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
            </div>
        </div>



        <div>
            <div class="tabbable">
                <div class="row-fluid">
                    <div class="span11" style="margin-top: 10px">
                        <table style="width: 100%" align="center" border="0" cellpadding="3" cellspacing="5">
                            <tr>
                                <td align="center">
                                    <button id="btnsave" style="display: block;" class="btn btn-lg btn-primary" type="button">
                                        <i class="icon-save bigger-160"></i>Modify
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
